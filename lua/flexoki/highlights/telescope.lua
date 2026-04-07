local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["TelescopeSelection"] = { fg = c['bl'] },
		["TelescopeMatching"]  = { fg = c['ye'], bold = true },
		["TelescopeBorder"]    = { fg = c['tx-3'], bg = c['bg'] },
	}
end

return M
