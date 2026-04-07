local palette = require('flexoki.palette')
local kinds = require('flexoki.highlights.kinds')

local M = {}

M.groups = function()
	local c = palette.palette()

	local ret = {
		["CmpDocumentation"]       = { fg = c['tx'],   bg = c['bg-2'] },
		["CmpDocumentationBorder"] = { fg = c['tx-3'], bg = c['bg-2'] },
		["CmpGhostText"]           = { fg = c['tx-3'] },
		["CmpItemAbbr"]            = { fg = c['tx'] },
		["CmpItemAbbrDeprecated"]  = { fg = c['tx-3'], strikethrough = true },
		["CmpItemAbbrMatch"]       = { fg = c['bl'] },
		["CmpItemAbbrMatchFuzzy"]  = { fg = c['bl'] },
		["CmpItemKindDefault"]     = { fg = c['tx-2'] },
		["CmpItemMenu"]            = { fg = c['tx-3'] },
	}

	kinds.kinds(ret, "CmpItemKind%s")
	return ret
end

return M
