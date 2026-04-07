# flexoki-neovim

Neovim colorscheme plugin using the [Flexoki](https://stephango.com/flexoki) color palette. Modeled after [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)'s architecture for highlight coverage and configuration, but with flexoki's own file structure and palette.

## Architecture

```
lua/flexoki/
├── init.lua              # Entry point: colorscheme() and setup()
├── config.lua            # All user-facing options
├── palette.lua           # Base colors + variant mapping (dark/light)
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
```

## Palette system

Colors are defined in `palette.lua`. There are 41 base hex values (grayscale + 8 hues at 600/400 levels), mapped to short semantic keys per variant:

| Key | Purpose | Dark example | Light example |
|-----|---------|-------------|---------------|
| `bg` | Background | `#100F0F` | `#FFFCF0` |
| `bg-2` | Sidebar/float bg | `#1C1B1A` | `#F2F0E5` |
| `ui` | Subtle UI (borders, cursorline) | `#282726` | `#E6E4D9` |
| `ui-2` | Medium UI | `#343331` | `#DAD8CE` |
| `ui-3` | Strong UI | `#403E3C` | `#CECDC3` |
| `tx-3` | Muted text (comments, line numbers) | `#575653` | `#B7B5AC` |
| `tx-2` | Dimmed text | `#878580` | `#6F6E69` |
| `tx` | Primary text | `#CECDC3` | `#100F0F` |
| `re` / `re-2` | Red (primary/secondary) | `#D14D41` / `#AF3029` | `#AF3029` / `#D14D41` |
| `or` / `or-2` | Orange | `#DA702C` / `#BC5215` | swapped |
| `ye` / `ye-2` | Yellow | `#D0A215` / `#AD8301` | swapped |
| `gr` / `gr-2` | Green | `#879A39` / `#66800B` | swapped |
| `cy` / `cy-2` | Cyan | `#3AA99F` / `#24837B` | swapped |
| `bl` / `bl-2` | Blue | `#4385BE` / `#205EA6` | swapped |
| `pu` / `pu-2` | Purple | `#8B7EC8` / `#5E409D` | swapped |
| `ma` / `ma-2` | Magenta | `#CE5D97` / `#A02F6F` | swapped |

In dark mode, primary hue (`re`, `bl`, etc.) is the 400-level (brighter). In light mode it's the 600-level (darker). The `-2` variant is always the opposite. This means the same key works correctly for both variants.

**Always use bracket notation** (`c['re']`, `c['bg-2']`), never dot notation (`c.red`, `c.error_red`). The palette has no dot-style keys — using them silently produces `nil` and breaks highlights.

## Config options

```lua
require('flexoki').setup({
    variant = 'auto',           -- 'auto' | 'dark' | 'light'
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
    on_colors = function(colors) end,      -- mutate palette before highlights
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
- **`util.blend(fg, bg, alpha)`** — alpha=0 is pure bg, alpha=1 is pure fg. Use ~0.1 for subtle tinted backgrounds (diagnostic virtual text), ~0.3 for borders (notify), ~0.8 for prominent backgrounds (treesitter-context).
- **`palette.palette()` is called per-module.** Each highlight module independently calls it. The `on_colors` hook runs each time but mutates the same underlying table, so this is safe.

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
- **Statusline themes** — no dedicated lualine/lightline/barbecue theme files.
- **HSLuv color space** — tokyonight uses it to generate the Day variant by inverting dark colors perceptually. Flexoki has hand-tuned light/dark palettes instead.
