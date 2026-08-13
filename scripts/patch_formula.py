#!/usr/bin/env python3
"""Patch Formula/*.rb GitHub Release urls + sha256 for a new version."""

from __future__ import annotations

import hashlib
import os
import re
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path


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
        out.append(f'{indent}url "{url}"\n')
        i += 1
        sha = _download_sha256(url)
        print(f"{url} sha256={sha}")
        if i < len(lines) and sha_re.match(lines[i].rstrip("\n")):
            sindent = re.match(r"^(\s*)", lines[i]).group(1) or indent
            out.append(f'{sindent}sha256 "{sha}"\n')
            i += 1
        else:
            out.append(f'{indent}sha256 "{sha}"\n')
    formula_file.write_text("".join(out))
    return 0


def _download_sha256(url: str) -> str:
    last_err: Exception | None = None
    for attempt in range(1, 37):
        try:
            with urllib.request.urlopen(url, timeout=60) as resp:
                data = resp.read()
            if len(data) > 100:
                return hashlib.sha256(data).hexdigest()
        except (OSError, TimeoutError, urllib.error.URLError) as exc:
            last_err = exc
            print(f"attempt {attempt}/36 {url}: {exc}")
        time.sleep(15)
    raise SystemExit(f"failed to download {url}: {last_err}")


if __name__ == "__main__":
    raise SystemExit(main())
