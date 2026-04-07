local highlights = require('flexoki.highlights')
local palette = require('flexoki.palette')
local utils = require('flexoki.util')

local M = {}

---@param c table
M.terminal = function(c)
	vim.g.terminal_color_0  = c['bg']
	vim.g.terminal_color_8  = c['ui-3']
	vim.g.terminal_color_1  = c['re-2']
	vim.g.terminal_color_9  = c['re']
	vim.g.terminal_color_2  = c['gr-2']
	vim.g.terminal_color_10 = c['gr']
	vim.g.terminal_color_3  = c['ye-2']
	vim.g.terminal_color_11 = c['ye']
	vim.g.terminal_color_4  = c['bl-2']
	vim.g.terminal_color_12 = c['bl']
	vim.g.terminal_color_5  = c['ma-2']
	vim.g.terminal_color_13 = c['ma']
	vim.g.terminal_color_6  = c['cy-2']
	vim.g.terminal_color_14 = c['cy']
	vim.g.terminal_color_7  = c['tx-2']
	vim.g.terminal_color_15 = c['tx']
end

---@param opts FlexokiOptions
M.set_highlights = function(opts)
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
