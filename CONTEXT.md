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
