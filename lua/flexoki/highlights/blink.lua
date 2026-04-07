local palette = require('flexoki.palette')
local kinds = require('flexoki.highlights.kinds')

local M = {}

M.groups = function()
	local c = palette.palette()

	local ret = {
		["BlinkCmpDoc"]                 = { fg = c['tx'],   bg = c['bg-2'] },
		["BlinkCmpDocBorder"]           = { fg = c['tx-3'], bg = c['bg-2'] },
		["BlinkCmpGhostText"]           = { fg = c['tx-3'] },
		["BlinkCmpKindDefault"]         = { fg = c['tx-2'] },
		["BlinkCmpLabel"]               = { fg = c['tx'] },
		["BlinkCmpLabelDeprecated"]     = { fg = c['tx-3'], strikethrough = true },
		["BlinkCmpLabelMatch"]          = { fg = c['bl'] },
		["BlinkCmpMenu"]                = { fg = c['tx'],   bg = c['bg-2'] },
		["BlinkCmpMenuBorder"]          = { fg = c['tx-3'], bg = c['bg-2'] },
		["BlinkCmpSignatureHelp"]       = { fg = c['tx'],   bg = c['bg-2'] },
		["BlinkCmpSignatureHelpBorder"] = { fg = c['tx-3'], bg = c['bg-2'] },
	}

	kinds.kinds(ret, "BlinkCmpKind%s")
	return ret
end

return M
