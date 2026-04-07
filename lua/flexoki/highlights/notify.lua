local palette = require('flexoki.palette')
local config = require('flexoki.config')
local util = require('flexoki.util')

local M = {}

M.groups = function()
	local c = palette.palette()
	local opts = config.options
	local transparent_bg = opts.transparent and 'NONE' or c['bg']

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["NotifyBackground"]  = { fg = c['tx'], bg = c['bg'] },
		["NotifyDEBUGBody"]   = { fg = c['tx'],   bg = transparent_bg },
		["NotifyDEBUGBorder"] = { fg = util.blend(c['tx-3'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyDEBUGIcon"]   = { fg = c['tx-3'] },
		["NotifyDEBUGTitle"]  = { fg = c['tx-3'] },
		["NotifyERRORBody"]   = { fg = c['tx'],   bg = transparent_bg },
		["NotifyERRORBorder"] = { fg = util.blend(c['re'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyERRORIcon"]   = { fg = c['re'] },
		["NotifyERRORTitle"]  = { fg = c['re'] },
		["NotifyINFOBody"]    = { fg = c['tx'],   bg = transparent_bg },
		["NotifyINFOBorder"]  = { fg = util.blend(c['cy'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyINFOIcon"]    = { fg = c['cy'] },
		["NotifyINFOTitle"]   = { fg = c['cy'] },
		["NotifyTRACEBody"]   = { fg = c['tx'],   bg = transparent_bg },
		["NotifyTRACEBorder"] = { fg = util.blend(c['pu'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyTRACEIcon"]   = { fg = c['pu'] },
		["NotifyTRACETitle"]  = { fg = c['pu'] },
		["NotifyWARNBody"]    = { fg = c['tx'],   bg = transparent_bg },
		["NotifyWARNBorder"]  = { fg = util.blend(c['ye'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyWARNIcon"]    = { fg = c['ye'] },
		["NotifyWARNTitle"]   = { fg = c['ye'] },
	}
end

return M
