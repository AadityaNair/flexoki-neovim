local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["WhichKey"]          = { fg = c['pu'] },
		["WhichKeySeparator"] = { fg = c['gr'] },
		["WhichKeyGroup"]     = { fg = c['bl'] },
		["WhichKeyDesc"]      = { fg = c['cy'] },
		["WhichKeyFloat"]     = { bg = c['bg-2'] },
	}
end

return M
