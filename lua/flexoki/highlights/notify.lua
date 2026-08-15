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
		["NotifyDEBUGBorder"] = { fg = util.blend(c['comment'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyDEBUGIcon"]   = { fg = c['comment'] },
		["NotifyDEBUGTitle"]  = { fg = c['comment'] },
		["NotifyERRORBody"]   = { fg = c['tx'],   bg = transparent_bg },
		["NotifyERRORBorder"] = { fg = util.blend(c['error'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyERRORIcon"]   = { fg = c['error'] },
		["NotifyERRORTitle"]  = { fg = c['error'] },
		["NotifyINFOBody"]    = { fg = c['tx'],   bg = transparent_bg },
		["NotifyINFOBorder"]  = { fg = util.blend(c['info'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyINFOIcon"]    = { fg = c['info'] },
		["NotifyINFOTitle"]   = { fg = c['info'] },
		["NotifyTRACEBody"]   = { fg = c['tx'],   bg = transparent_bg },
		["NotifyTRACEBorder"] = { fg = util.blend(c['pu'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyTRACEIcon"]   = { fg = c['pu'] },
		["NotifyTRACETitle"]  = { fg = c['pu'] },
		["NotifyWARNBody"]    = { fg = c['tx'],   bg = transparent_bg },
		["NotifyWARNBorder"]  = { fg = util.blend(c['warning'], c['bg'], 0.3), bg = transparent_bg },
		["NotifyWARNIcon"]    = { fg = c['warning'] },
		["NotifyWARNTitle"]   = { fg = c['warning'] },
	}
end

return M
