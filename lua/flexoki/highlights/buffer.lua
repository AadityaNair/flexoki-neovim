local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["BufferLineIndicatorSelected"] = { fg = c['or'] },
	}
end

return M
