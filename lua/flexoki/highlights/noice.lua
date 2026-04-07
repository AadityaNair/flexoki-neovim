local palette = require('flexoki.palette')
local kinds = require('flexoki.highlights.kinds')

local M = {}

M.groups = function()
	local c = palette.palette()

	local ret = {
		["NoiceCmdlineIconInput"]          = { fg = c['ye'] },
		["NoiceCmdlineIconLua"]            = { fg = c['bl'] },
		["NoiceCmdlinePopupBorderInput"]   = { fg = c['ye'] },
		["NoiceCmdlinePopupBorderLua"]     = { fg = c['bl'] },
		["NoiceCmdlinePopupTitleInput"]    = { fg = c['ye'] },
		["NoiceCmdlinePopupTitleLua"]      = { fg = c['bl'] },
		["NoiceCompletionItemKindDefault"] = { fg = c['tx-2'] },
	}

	kinds.kinds(ret, "NoiceCompletionItemKind%s")
	return ret
end

return M
