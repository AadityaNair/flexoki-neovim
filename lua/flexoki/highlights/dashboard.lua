local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["DashboardHeader"] = { fg = c['bl'] },
		["DashboardCenter"] = { fg = c['pu'] },
		["DashboardFooter"] = { fg = c['cy'] },
	}
end

return M
