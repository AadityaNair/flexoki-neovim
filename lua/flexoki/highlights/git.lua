local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["GitSignsAdd"]    = { fg = c['gr'] },
		["GitSignsChange"] = { fg = c['or'] },
		["GitSignsDelete"] = { fg = c['re'] },
		["SignAdd"]        = { fg = c['gr'] },
		["SignChange"]     = { fg = c['or'] },
		["SignDelete"]     = { fg = c['re'] },
	}
end

return M
