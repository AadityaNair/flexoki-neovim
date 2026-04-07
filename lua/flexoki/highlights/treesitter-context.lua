local palette = require('flexoki.palette')
local util = require('flexoki.util')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["TreesitterContext"]           = { bg = util.blend(c['ui'], c['bg'], 0.8) },
		["TreesitterContextLineNumber"] = { fg = c['tx-3'], bg = util.blend(c['ui'], c['bg'], 0.8) },
	}
end

return M
