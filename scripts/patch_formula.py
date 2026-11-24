#!/usr/bin/env python3
"""Patch Formula/*.rb GitHub Release urls + sha256 for a new version."""

from __future__ import annotations

import hashlib
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

_MANIFEST_CACHE: dict[str, dict] = {}


def main() -> int:
    formula_name = os.environ["FORMULA_NAME"]
    version = os.environ["VERSION"]
    formula_file = Path("Formula") / f"{formula_name}.rb"
    text = formula_file.read_text()
    if "releases/download/" not in text:
        print("expected GitHub Release binary urls in formula", file=sys.stderr)
        return 1
    text = re.sub(r'^(\s*version\s+")[^"]+(")', rf"\g<1>{version}\g<2>", text, count=1, flags=re.M)
    text = re.sub(r"(releases/download/)v[^/]+/", rf"\g<1>v{version}/", text)
    lines = text.splitlines(keepends=True)
    url_re = re.compile(r'^(\s*)url\s+"(https://github.com/[^"]+/releases/download/v[^/]+/[^"]+)"\s*$')
    sha_re = re.compile(r'^(\s*)sha256\s+"[0-9a-fA-F]{64}"\s*$')
    out: list[str] = []
    i = 0
    while i < len(lines):
        m = url_re.match(lines[i].rstrip("\n"))
        if not m:
            out.append(lines[i])
            i += 1
            continue
        indent, url = m.group(1), m.group(2)
        if formula_name == "agent-toolkit":
            url = _standalone_archive_url(url, version)
        out.append(f'{indent}url "{url}"\n')
        i += 1
        sha = _download_manifest_sha256(url)
        print(f"{url} sha256={sha}")
        if i < len(lines) and sha_re.match(lines[i].rstrip("\n")):
            sindent = re.match(r"^(\s*)", lines[i]).group(1) or indent
            out.append(f'{sindent}sha256 "{sha}"\n')
            i += 1
        else:
            out.append(f'{indent}sha256 "{sha}"\n')
    formula_file.write_text("".join(out))
    return 0


def _download_manifest_sha256(url: str) -> str:
    last_err: Exception | None = None
    for attempt in range(1, 37):
        try:
            with urllib.request.urlopen(url, timeout=60) as resp:
                data = resp.read()
            if len(data) > 100:
                tag = urllib.parse.urlsplit(url).path.split("/")[-2]
                manifest = _verified_manifest(tag)
                filename = Path(url).name
                platform = re.search(r"(macos-arm64|macos-x86_64|linux-x86_64|linux-arm64)", filename)
                if not platform:
                    raise SystemExit(f"unsupported Agent Toolkit archive name: {filename}")
                os_name, arch = platform.group(1).rsplit("-", 1)
                if os_name == "linux":
                    os_name = "linux"
                elif os_name == "macos":
                    os_name = "macos"
                entry = _select_archive(manifest, filename, os_name, arch, "gnu" if os_name == "linux" else None)
                return _verified_asset_sha(entry, data)
        except urllib.error.HTTPError as exc:
            last_err = exc
            if 400 <= exc.code < 500 and exc.code != 429:
                raise SystemExit(f"{url} HTTP {exc.code}") from exc
            print(f"attempt {attempt}/36 {url}: HTTP {exc.code}")
        except (OSError, TimeoutError, urllib.error.URLError) as exc:
            last_err = exc
            print(f"attempt {attempt}/36 {url}: {exc}")
        time.sleep(15)
    raise SystemExit(f"failed to download {url}: {last_err}")


def _verified_manifest(tag: str) -> dict:
    if tag not in _MANIFEST_CACHE:
        manifest_url = f"https://github.com/ulises-jeremias/agent-toolkit/releases/download/{tag}/manifest.json"
        request = urllib.request.Request(manifest_url, headers={"User-Agent": "agent-toolkit-release-updater"})
        with urllib.request.urlopen(request, timeout=60) as resp:
            manifest = json.load(resp)
        commit_url = f"https://api.github.com/repos/ulises-jeremias/agent-toolkit/commits/{tag}"
        commit_request = urllib.request.Request(
            commit_url,
            headers={"Accept": "application/vnd.github+json", "User-Agent": "agent-toolkit-release-updater"},
        )
        with urllib.request.urlopen(commit_request, timeout=60) as resp:
            tagged_commit = json.load(resp).get("sha")
        _verify_manifest_identity(manifest, tag, tagged_commit)
        _MANIFEST_CACHE[tag] = manifest
    return _MANIFEST_CACHE[tag]


def _standalone_archive_url(url: str, version: str) -> str:
    match = re.fullmatch(
        r"agent-toolkit-(?:(?:\d+\.)*\d+-)?(macos-arm64|macos-x86_64|linux-x86_64|linux-arm64)(?:\.tar\.gz)?",
        Path(url).name,
    )
    if not match:
        raise SystemExit(f"unsupported Agent Toolkit release asset in formula URL: {url}")
    return f"{url.rsplit('/', 1)[0]}/agent-toolkit-{version}-{match.group(1)}.tar.gz"


def _verify_manifest_identity(manifest: dict, tag: str, tagged_commit: str) -> None:
    source_sha = manifest.get("sourceSha", "")
    if (
        manifest.get("name") != "agent-toolkit"
        or manifest.get("version") != tag.removeprefix("v")
        or manifest.get("gitTag") != tag
        or manifest.get("channel") != "stable"
        or not re.fullmatch(r"[0-9a-f]{40}", source_sha)
    ):
        raise SystemExit(f"release manifest identity/sourceSha does not match tag {tag}")
    if tagged_commit != source_sha:
        raise SystemExit(f"manifest sourceSha {source_sha} does not match tag {tag} commit {tagged_commit}")


def _verified_asset_sha(asset: dict, data: bytes) -> str:
    actual = hashlib.sha256(data).hexdigest()
    expected = asset.get("sha256")
    if actual != expected:
        raise SystemExit(f"SHA-256 mismatch for {asset.get('filename')}: manifest={expected} downloaded={actual}")
    return expected


def _select_archive(manifest: dict, filename: str, os_name: str, arch: str, libc: str | None) -> dict:
    matches = [
        asset
        for asset in manifest.get("assets", [])
        if asset.get("filename") == filename
        and asset.get("kind") == "archive"
        and asset.get("channel") == "stable"
        and asset.get("os") == os_name
        and asset.get("arch") == arch
        and asset.get("libc") == libc
    ]
    if len(matches) != 1:
        raise SystemExit(f"manifest must contain exactly one matching archive entry for {filename}")
    return matches[0]


if __name__ == "__main__":
    raise SystemExit(main())
