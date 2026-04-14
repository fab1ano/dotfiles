# Cheat Sheet

## Bash / Readline

| Keys | Action |
|---|---|
| `C-w` | Delete last word |
| `C-u` | Cut from cursor to start of line |
| `C-k` | Cut from cursor to end of line |
| `C-y` | Paste what you cut (yank) |
| `C-a` / `C-e` | Jump to beginning / end of line |
| `M-b` / `M-f` | Jump back / forward one word |
| `Esc .` | Insert last argument of previous command |

## Shell tricks

```sh
diff <(sort file1.txt) <(sort file2.txt)   # compare sorted output
```

## Vim — search & editing

| Keys | Action |
|---|---|
| `/{pattern}/{offset}` | Search with line offset |
| `cc` | Delete entire line and insert |
| `"xcc` | Delete line into register `x` and insert |
| `C` | Delete to end of line and insert |
| `s` | Delete current char and insert |

Tip: enable persistent undo with `set undofile` and `set undodir=~/.vim/undo`.

## Neovim — fuzzy picker (fzf-lua)

Leader = `\` (default).

| Keys | Action |
|---|---|
| `\ff` | Find files |
| `\fg` | Live grep (project-wide string search) |
| `\fb` | Open buffers |
| `\fs` | LSP workspace symbols |
| `\fd` | LSP document symbols (current file) |
| `\fr` | LSP references under cursor |

## Neovim — sidebars

| Keys | Action |
|---|---|
| `\a`  | Toggle Aerial outline |
| `\xx` | Trouble diagnostics |
| `\xs` | Trouble symbols |
| `\xr` | Trouble LSP references |

## Neovim — LSP

| Keys | Action |
|---|---|
| `K` | Hover docs |
| `gd` / `gD` | Definition / declaration |
| `gi` | Implementation |
| `gr` | References |
| `C-k` | Signature help |
| `\rn` | Rename |
| `\ca` | Code action |

## Neovim — misc

| Keys | Action |
|---|---|
| `C-n` | fzf.vim `:Files` |
| `C-p` | New tab + `:Files` |
| `,` | Toggle Neotree |
