# mod-template

A Claude Code mod (function-hook plugin). Replace this paragraph with what the mod does and why, in two or three sentences.

> This repository is also the template for new mods: `scripts/new-mod.sh <mod-name>` creates `../claude-<mod-name>` with every `mod-template` renamed, a fresh git history and one commit. Delete this note in the new repo.

## Behavior

- What the mod does, when, and to which conversations (main only, or subagents too).
- What it costs (model calls, tokens) and how the options bound it.
- What it never does.

## Command

`/mod-template [on|off|status]`: show or set whether the mod is on for this session.

## Options

| Option | Default | What it does |
| --- | --- | --- |
| `enabled` | `true` | Turn the mod on for new sessions. `/mod-template on|off` overrides it per session. |

## Install

```sh
claude plugin marketplace add chrisvaillancourt/claude-mod-template
claude plugin install mod-template@mod-template --scope user
```

Or from inside Claude Code: `/plugin install mod-template --marketplace chrisvaillancourt/claude-mod-template`.

To work on it locally, run a session with your clone loaded: `claude --plugin-dir <path to clone>` (that session only; saving a file reloads it). If the plugin is also installed, add `--settings '{"enabledPlugins":{"mod-template@mod-template":false}}'` so only the clone loads. An installed copy, even one installed from a local clone with `claude plugin marketplace add <path to clone>`, is a snapshot under `~/.claude/plugins/cache/`; edits to the clone reach it only after you bump `version` in `.claude-plugin/plugin.json` and run the update commands below.

## Update

```sh
claude plugin marketplace update mod-template
claude plugin update mod-template@mod-template
```

Then restart Claude Code.

## Develop

```sh
scripts/check.sh
```

It runs `claude plugin validate .`, `claude plugin test .` and a TypeScript check. Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/).

## License

MIT. See [LICENSE](LICENSE).
