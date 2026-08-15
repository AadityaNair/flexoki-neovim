local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["TreesitterContext"]           = { bg = c['bg-highlight'] },
		["TreesitterContextLineNumber"] = { fg = c['comment'], bg = c['bg-highlight'] },
	}
end

return M
