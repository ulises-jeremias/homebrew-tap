# homebrew-tap

> Homebrew tap for [ulises-jeremias](https://github.com/ulises-jeremias) packages.

## Usage

```bash
brew tap ulises-jeremias/homebrew-tap
brew install agent-toolkit
```

## Available Formulae

| Formula | Description | Install |
|---------|-------------|---------|
| [agent-toolkit](Formula/agent-toolkit.rb) | Native V CLI from GitHub Releases (not a Python wheel) | `brew install ulises-jeremias/homebrew-tap/agent-toolkit` |

## Adding a new formula

1. Create `Formula/<name>.rb` following the patterns in existing formulae
2. Add an entry to the table above
3. Add the update workflow trigger to the package's release CI

## Auto-update mechanism

Each formula auto-updates via `repository_dispatch` events sent by the package's release CI.
The `update-formula.yml` workflow handles any formula — just pass `formula_name` and `version`.

## CI secrets and permissions (maintainer)

Formula bumps are opened by `.github/workflows/update-formula.yml` after a `repository_dispatch` from package repos (e.g. `agent-toolkit` `notify-homebrew.yml`).

### Required: Actions can create PRs

In this repo: **Settings → Actions → General → Workflow permissions**:

1. Prefer **Read and write permissions** (or keep read default and rely on the workflow `permissions:` block).
2. Enable **Allow GitHub Actions to create and approve pull requests**.

Without (2), `GITHUB_TOKEN` fails with:

`GitHub Actions is not permitted to create or approve pull requests (createPullRequest)`

Branches still push; PRs must then be opened manually (as happened for #13 / #14).

Verify via API:

```bash
gh api repos/ulises-jeremias/homebrew-tap/actions/permissions/workflow
# expect: "can_approve_pull_request_reviews": true
```

### Required: `HOMEBREW_TAP_TOKEN` (environment `homebrew`)

Store as an **environment secret** named `HOMEBREW_TAP_TOKEN` on the `homebrew` environment (used by both this tap and the notifying package repo).

Fine-grained PAT (recommended), resource owner `ulises-jeremias`, repository access to **this tap** (and to package repos that wait on releases if private):

| Permission | Access | Why |
|---|---|---|
| Contents | Read and write | Push `chore/<formula>-v*` branches |
| Pull requests | Read and write | Fallback PR create when Actions PR setting is off |
| Metadata | Read | Required by GitHub |

Classic PAT alternative: `repo` scope covering this tap.

Also add the **same secret** to each notifying package repo (e.g. `ulises-jeremias/agent-toolkit` environment `homebrew`) so `notify-homebrew.yml` can:

- `gh release view` / wait for assets
- `POST /repos/ulises-jeremias/homebrew-tap/dispatches` (`repository_dispatch` needs write access to this tap)

Do **not** commit tokens. Rotate if a PR-create 403 persists after the Actions setting above is enabled — the PAT likely lacks **Pull requests: Write**.
