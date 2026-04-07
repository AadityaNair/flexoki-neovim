local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		-- v3 (indent-blankline.nvim)
		["IblIndent"] = { fg = c['ui-2'], nocombine = true },
		["IblScope"]  = { fg = c['bl'],   nocombine = true },
		-- Legacy v2 names
		["IndentBlanklineChar"]         = { fg = c['ui-2'], nocombine = true },
		["IndentBlanklineContextChar"]  = { fg = c['bl'],   nocombine = true },
		["IndentBlanklineContextStart"] = { underline = true, sp = c['bl'] },
	}
end

return M
