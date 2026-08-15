local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["GitSignsAdd"]    = { fg = c['git-add'] },
		["GitSignsChange"] = { fg = c['git-change'] },
		["GitSignsDelete"] = { fg = c['git-delete'] },
		["SignAdd"]        = { fg = c['git-add'] },
		["SignChange"]     = { fg = c['git-change'] },
		["SignDelete"]     = { fg = c['git-delete'] },
	}
end

return M
