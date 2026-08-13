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
