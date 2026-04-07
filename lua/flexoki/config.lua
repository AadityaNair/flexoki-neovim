---@alias Variant 'dark' | 'light'
---@alias FloatWindowStyle 'auto' | 'border' | 'solid' | 'borderless'

local M = {}

---@class FlexokiOptions
M.options = {
	---Set the desired variant: 'auto' will follow the vim background,
	---defaulting to 'main' for dark and 'dawn' for light. To change the dark
	---variant, use `options.dark_variant = 'moon'`.
	---@type 'auto' | Variant | nil
	variant = 'auto',

	---Set the desired dark variant: applies when `options.variant` is set to
	---'auto' to match `vim.o.background`.
	---@type Variant?
	dark_variant = 'dark',

	---Set the desired light variant: applies when `options.variant` is set to
	---'auto' to match `vim.o.background`
	---@type Variant?
	light_variant = 'light',

	---Make background transparent (sets Normal bg to NONE)
	---@type boolean
	transparent = false,

	---Set terminal colors (vim.g.terminal_color_*)
	---@type boolean
	terminal_colors = true,

	---Dim inactive windows (NormalNC gets darker background)
	---@type boolean
	dim_inactive = false,

	---Style overrides for syntax groups
	---@type { comments: vim.api.keyset.highlight?, keywords: vim.api.keyset.highlight?, functions: vim.api.keyset.highlight?, variables: vim.api.keyset.highlight? }
	styles = {
		comments = {},
		keywords = {},
		functions = {},
		variables = {},
	},

	---The style to use for float windows, `winborder == 'none'` works best
	---with a different background than code, while all the other ones work
	---best with the same one, 'auto' will check `vim.opt.winborder` when
	---applying the colorscheme to decide
	---@type FloatWindowStyle?
	float_window_style = 'auto',

	---Hook to modify colors before highlights are generated
	---@type fun(colors: table)?
	on_colors = nil,

	---Hook to modify highlights before they are applied
	---@type fun(highlights: table, colors: table)?
	on_highlights = nil,

	---@type table<string, vim.api.keyset.highlight>?
	highlight_groups = {},
}

---@param options FlexokiOptions|nil
function M.extend(options)
	M.options = vim.tbl_deep_extend('force', M.options, options or {})
end

return M
