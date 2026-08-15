# flexoki-neovim

Neovim colorscheme plugin using the [Flexoki](https://stephango.com/flexoki) color palette. Modeled after [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)'s architecture for highlight coverage and configuration, but with flexoki's own file structure and palette.

## Architecture

```
lua/flexoki/
├── init.lua              # Entry point: colorscheme() and setup()
├── config.lua            # All user-facing options
├── palette.lua           # Spec colors, variant mapping, semantic slots
├── theme.lua             # Applies highlights, terminal colors, runs hooks
├── util.lua              # blend() and highlight() helpers
└── highlights/
    ├── init.lua          # Aggregator — lists all modules, merges into one table
    ├── base.lua          # ~140 core Vim highlight groups
    ├── treesitter.lua    # ~120 treesitter captures (legacy + modern)
    ├── semantic-tokens.lua # ~40 @lsp.type.* / @lsp.typemod.* captures
    ├── kinds.lua         # LSP kind system (LspKindClass, etc.) + reusable helper
    ├── blink.lua         # blink.cmp completion
    ├── cmp.lua           # nvim-cmp completion (uses kinds helper)
    ├── noice.lua         # noice.nvim (uses kinds helper)
    ├── notify.lua        # nvim-notify
    ├── treesitter-context.lua
    ├── mini-nvim.lua     # mini.nvim suite (~60 groups)
    ├── flash-nvim.lua
    ├── neotree.lua
    ├── nvim-tree.lua
    ├── todo-comments.lua
    ├── git.lua           # gitsigns
    ├── buffer.lua        # bufferline.nvim
    ├── indent-blank-line.lua
    ├── lsp.lua           # deprecated LspDiagnostics* compat shim
    ├── markdown.lua
    ├── telescope.lua
    ├── whichkey.lua
    ├── dashboard.lua
    └── _template.lua     # Empty template for new modules

lua/lualine/themes/
└── flexoki-dark.lua      # lualine theme (dark only)
```

## Palette system

`palette.lua` holds the complete published Flexoki spec — 119 hex values (14 base tones plus 8 hues at 13 levels each), generated verbatim from [`kepano/flexoki`](https://github.com/kepano/flexoki/blob/main/css/flexoki.css). Those raw values are never used directly by highlight modules; they feed the variant tables below.

`palette.palette()` returns a single flat table with three layers of keys.

### 1. Base UI keys

| Key | Purpose | Dark | Light |
|-----|---------|------|-------|
| `bg` | Background | `#100F0F` | `#FFFCF0` |
| `bg-2` | Sidebar/float bg | `#1C1B1A` | `#F2F0E5` |
| `ui` | Subtle UI (cursorline) | `#282726` | `#E6E4D9` |
| `ui-2` | Medium UI | `#343331` | `#DAD8CE` |
| `ui-3` | Strong UI | `#403E3C` | `#CECDC3` |
| `tx-3` | Muted text (comments, line numbers) | `#575653` | `#B7B5AC` |
| `tx-2` | Dimmed text | `#878580` | `#6F6E69` |
| `tx` | Primary text | `#CECDC3` | `#100F0F` |

### 2. Accent tiers

Eight hues — `re` `or` `ye` `gr` `cy` `bl` `pu` `ma` — each with five tiers:

| Suffix | Purpose | Dark level | Light level |
|--------|---------|-----------|------------|
| *(none)* | Primary accent | 400 | 600 |
| `-2` | Dim / secondary accent | 600 | 400 |
| `-3` | Bright / emphasis | 300 | 700 |
| `-bg` | Subtle tinted background | 950 | 50 |
| `-bg-2` | Stronger tinted background | 900 | 100 |

So `c['re-3']` is bright red, `c['bl-bg']` is a subtle blue-tinted background. 40 accent slots in total.

The mirroring follows Flexoki's own rule: dark mode takes the 400 level as its primary accent, light mode takes 600, and every other tier is mirrored around that. The same key therefore works in both variants. These are generated in `palette.lua` from a hue list and a per-variant level map, so the rule is stated once; a missing level raises an assertion rather than silently producing `nil`.

### 3. Semantic slots

Derived on top of the variant. Prefer these over naming a hue directly — a highlight should say what it means, so that one `on_colors` override retunes everything related.

| Group | Keys |
|-------|------|
| Text | `fg` `fg-dark` `fg-gutter` `fg-float` `fg-sidebar` `comment` |
| Backgrounds | `bg-float` `bg-float-border` `bg-popup` `bg-sidebar` `bg-statusline` `bg-visual` `bg-search` `bg-highlight` |
| Borders | `border` `border-highlight` |
| Diagnostics | `error` `warning` `info` `hint` `ok` `todo` and `error-bg` `warning-bg` `info-bg` `hint-bg` `ok-bg` |
| Git | `git-add` `git-change` `git-delete` `git-ignore` |
| Diff | `diff-add` `diff-change` `diff-delete` `diff-text` |
| Cycling | `rainbow` and `rainbow-bg` (8-entry arrays, matched by index) |
| Terminal | `term-0` … `term-15` |
| Literal | `none` (the string `'NONE'`) |

`bg-float` / `bg-float-border` already account for `float_window_style` and `vim.o.winborder`, so modules drawing a float should use them rather than re-deriving the answer.

**Always use bracket notation** (`c['re']`, `c['error']`, `c['bg-2']`), never dot notation (`c.red`, `c.error_red`). The palette has no dot-style keys — using them silently produces `nil` and breaks highlights.

### Resolution order

`palette.palette()` resolves once and caches; `theme.set_highlights()` calls `palette.reset()` first so config and background changes take effect. Each resolution works on a deepcopy of the variant, so hooks cannot leak into later resolutions. Order is: variant colours → semantic slots → `on_colors`. Because `on_colors` runs last, it can override derived slots (`c['error']`, `c['bg-float']`), not just raw hues.

## Config options

```lua
require('flexoki').setup({
    variant = 'auto',           -- 'auto' | 'dark' | 'light'
    dark_variant = 'dark',      -- used when variant = 'auto' and background = dark
    light_variant = 'light',    -- used when variant = 'auto' and background = light
    transparent = false,        -- Normal bg = NONE
    terminal_colors = true,     -- set vim.g.terminal_color_*
    dim_inactive = false,       -- NormalNC gets darker bg
    styles = {
        comments = {},          -- e.g. { italic = true }
        keywords = {},
        functions = {},
        variables = {},
    },
    float_window_style = 'auto', -- 'auto' | 'border' | 'solid' | 'borderless'
    on_colors = function(colors) end,      -- mutate palette (incl. semantic slots) before highlights
    on_highlights = function(hl, c) end,   -- mutate highlights before applying
    highlight_groups = {},                  -- final overrides (highest priority)
})
```

## Adding a new plugin module

1. Copy `_template.lua` to `highlights/<plugin-name>.lua`
2. Follow the pattern:
   ```lua
   local palette = require('flexoki.palette')
   local M = {}
   M.groups = function()
       local c = palette.palette()
       return {
           ["HighlightGroup"] = { fg = c['bl'], bg = c['bg-2'] },
       }
   end
   return M
   ```
3. Add `require('flexoki.highlights.<plugin-name>').groups()` to `highlights/init.lua`

For completion-style plugins that need LSP kind colors, use the `kinds` helper:
```lua
local kinds = require('flexoki.highlights.kinds')
-- Inside M.groups():
kinds.kinds(ret, "PluginKind%s")  -- generates PluginKindClass, PluginKindFunction, etc.
```

### Which colour to reach for

Work down this list and stop at the first row that fits. Naming a raw hue is the
last resort, not the default.

| The group means… | Use |
|---|---|
| An error / warning / info / hint / success | `c['error']` `c['warning']` `c['info']` `c['hint']` `c['ok']` |
| …and needs a tinted background behind it | the matching `c['error-bg']`, etc. |
| Added / changed / deleted in git | `c['git-add']` `c['git-change']` `c['git-delete']` |
| A diff region's background | `c['diff-add']` `c['diff-change']` `c['diff-delete']` `c['diff-text']` |
| Body text, dimmed text, a comment | `c['fg']` `c['fg-dark']` `c['comment']` |
| A float / popup / sidebar / statusline background | `c['bg-float']` `c['bg-popup']` `c['bg-sidebar']` `c['bg-statusline']` |
| A float's border | `c['border']` on `c['bg-float-border']` |
| A selection or a search match | `c['bg-visual']` `c['bg-search']` |
| Cycling through N colours (heading levels, nesting) | `c['rainbow'][i]` + `c['rainbow-bg'][i]` |
| Genuinely just "the blue one" | `c['bl']` and its tiers |

When it really is a raw hue, pick the tier by role rather than by eye:

- `c['bl']` — the default; ordinary coloured text.
- `c['bl-2']` — a second, quieter thing sitting next to something already using `bl`.
- `c['bl-3']` — this must *win* attention: the current match, the matched bracket,
  the selected item.
- `c['bl-bg']` / `c['bl-bg-2']` — a background tint under otherwise-normal text.
  Don't put unrelated foreground text on these; they're a wash, not a fill.

Avoid inverting a saturated accent as a background with `fg = c['bg']` unless the
group is genuinely modal (current search match, mode indicator). It overrides the
syntax highlighting underneath, which is why the `Diff*` groups moved off that
pattern.

### Verifying a change

There are no tests, so diff the *resolved* highlights instead. This catches both
"I broke something unrelated" and "my refactor wasn't the no-op I claimed".
`:highlight` output order is nondeterministic, so always sort before diffing.

```sh
dump() {  # $1 = colorscheme, $2 = outfile
  nvim --headless --noplugin -u NONE -c "set rtp+=$PWD" \
    -c "colorscheme $1" -c "redir! > $2.raw" -c "silent highlight" \
    -c "redir END" -c qa 2>/dev/null
  grep -v '^$' "$2.raw" | sort > "$2"
}
dump flexoki-dark after.txt
git stash -q && dump flexoki-dark before.txt && git stash pop -q
diff before.txt after.txt        # expect no output for a pure refactor
```

Run it for `flexoki-light` too — bugs have shown up in only one variant.

To catch the palette-typo failure mode specifically (a bad key resolves to `nil`,
which `util.highlight` turns into `'none'`, so the group silently renders
unstyled):

```sh
nvim --headless --noplugin -u NONE -c "set rtp+=$PWD" -c "colorscheme flexoki-dark" -c "lua
  for _, g in ipairs(vim.fn.getcompletion('', 'highlight')) do
    local h = vim.api.nvim_get_hl(0, { name = g })
    if not h.link and next(h) == nil then print('EMPTY: ' .. g) end
  end" -c qa
```

A short list is expected: groups that are deliberately cleared (`@none`,
`Conceal`, `EndOfBuffer`, `SignColumn`, `Statement`, `MatchParenCur`, …) plus a
few Neovim built-ins the theme doesn't set. Anything else in that list is a typo.

### Keeping the terminal palette in sync

`term-0`…`term-15` are also the reference for the terminal emulator's own ANSI
palette. If these change, the emulator config should change with them, otherwise
a `:terminal` buffer and a bare shell disagree. See `THEME.md` in the dotfiles
repo, which tracks the other side of that.

## Common pitfalls

- **Palette key typos silently break highlights.** `c['re']` works, `c.red` / `c.error_red` returns nil. All disabled modules were originally broken because of this.
- **`link` overrides all other attributes.** If a highlight needs both a color and a style (e.g. italic), use direct `fg`/`bg` values, not `link`. This matters for style-aware groups (`@function`, `@keyword`, `@variable`, `Comment`).
- **`util.highlight()` sets fg/bg to `'none'` when absent.** This is fine for most groups but means link-only groups get extra properties — Neovim ignores them when `link` is present.
- **Don't blend a tinted background — use the `-bg` tier.** Flexoki publishes those shades, so `c['re-bg']` beats `util.blend(c['re'], c['bg'], 0.1)`: it is the real colour rather than an interpolation, costs nothing per apply, and does not silently drift when `transparent = true` (where the blend mixes against a background that is not on screen).
- **`util.blend(fg, bg, alpha)`** — alpha=0 is pure bg, alpha=1 is pure fg. Still the right tool for a *dimmed accent*, which the spec has no level for: nvim-notify's borders use ~0.3, matching tokyonight.
- **Name the meaning, not the hue.** `c['error']` over `c['re']`, `c['git-add']` over `c['gr']`. Groups that named hues directly are why `WarningMsg` was red and identical to an error for so long.

## Color assignments for todo-comments

Each keyword uses a unique color — no collisions:

| Keyword | Color key |
|---------|-----------|
| FIX | `re` (red) |
| TODO | `bl` (blue) |
| HACK | `or` (orange) |
| WARN | `ye` (yellow) |
| PERF | `pu` (purple) |
| NOTE | `ma` (magenta) |
| INFO | `cy` (cyan) |
| TEST | `gr` (green) |

## What's NOT implemented (intentionally deferred)

- **Extras system** — tokyonight generates configs for 40+ external tools (alacritty, kitty, tmux, etc.). Not ported.
- **Caching** — tokyonight caches resolved highlights to JSON. Not needed at current scale.
- **Plugin auto-detection** — tokyonight auto-detects lazy.nvim plugins. Here all modules load unconditionally.
- **Statusline themes** — only `lua/lualine/themes/flexoki-dark.lua` exists; there is no light lualine theme and no lightline/barbecue theme.
- **HSLuv color space** — tokyonight uses it to generate the Day variant by inverting dark colors perceptually, and to brighten the ANSI colors. Flexoki publishes hand-tuned levels for both variants, so the same results come from picking a different level (see the accent tier table) with no color-space math.
- **A handful of highlight groups** — `@namespace.builtin`, `@number.float`, `ComplHint`, `LspInfoBorder`, and the legacy `DiagnosticWarning` / `DiagnosticInformation` aliases are not defined.
