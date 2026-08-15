local highlights = require('flexoki.highlights')
local palette = require('flexoki.palette')
local utils = require('flexoki.util')

local M = {}

---@param c table
M.terminal = function(c)
	for i = 0, 15 do
		vim.g['terminal_color_' .. i] = c['term-' .. i]
	end
end

---@param opts FlexokiOptions
M.set_highlights = function(opts)
	-- Config or background may have changed since the last apply, and the
	-- 21 highlight modules below all call palette.palette(); resolve once.
	palette.reset()

	local c = palette.palette()
	local highlight_groups = highlights.groups()

	-- on_highlights hook (before user overrides)
	if opts.on_highlights then
		opts.on_highlights(highlight_groups, c)
	end

	-- User highlight_groups overrides (most specific, applied last)
	if opts.highlight_groups ~= nil then
		for group, highlight in pairs(opts.highlight_groups) do
			highlight_groups[group] = highlight
		end
	end

	for group, highlight in pairs(highlight_groups) do
		utils.highlight(group, highlight)
	end

	if opts.terminal_colors then
		M.terminal(c)
	end
end

return M
