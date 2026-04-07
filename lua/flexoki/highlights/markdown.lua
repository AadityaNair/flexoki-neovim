local palette = require('flexoki.palette')

local M = {}

M.groups = function()
	local c = palette.palette()

	--- @type table<string, vim.api.keyset.highlight>
	return {
		["markdownBlockquote"]         = { fg = c['gr'] },
		["markdownCode"]               = { fg = c['or'] },
		["markdownCodeBlock"]          = { fg = c['or'] },
		["markdownCodeDelimiter"]      = { fg = c['or'] },
		["markdownH1"]                 = { fg = c['bl'], bold = true },
		["markdownH2"]                 = { fg = c['bl'], bold = true },
		["markdownH3"]                 = { fg = c['bl'], bold = true },
		["markdownH4"]                 = { fg = c['bl'], bold = true },
		["markdownH5"]                 = { fg = c['bl'], bold = true },
		["markdownH6"]                 = { fg = c['bl'], bold = true },
		["markdownHeadingDelimiter"]   = { fg = c['bl'] },
		["markdownHeadingRule"]        = { fg = c['tx'], bold = true },
		["markdownId"]                 = { fg = c['pu'] },
		["markdownIdDeclaration"]      = { fg = c['bl'] },
		["markdownIdDelimiter"]        = { fg = c['tx-3'] },
		["markdownLinkDelimiter"]      = { fg = c['tx-3'] },
		["markdownBold"]               = { fg = c['bl'], bold = true },
		["markdownItalic"]             = { italic = true },
		["markdownBoldItalic"]         = { fg = c['ye'], bold = true, italic = true },
		["markdownListMarker"]         = { fg = c['bl'] },
		["markdownOrderedListMarker"]  = { fg = c['bl'] },
		["markdownRule"]               = { fg = c['tx-2'] },
		["markdownUrl"]                = { fg = c['cy'], underline = true },
		["markdownLinkText"]           = { fg = c['bl'] },
		["markdownFootnote"]           = { fg = c['or'] },
		["markdownFootnoteDefinition"] = { fg = c['or'] },
		["markdownEscape"]             = { fg = c['ye'] },
	}
end

return M
