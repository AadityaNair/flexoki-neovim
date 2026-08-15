local palette = require('flexoki.palette')
local config = require('flexoki.config')

local M = {}

M.groups = function()
	local c = palette.palette()
	local opts = config.options

	local transparent_bg = opts.transparent and 'NONE' or c['bg']
	local dim_bg = opts.dim_inactive and c['bg-2'] or 'NONE'

	local floatBg = 'bg'
	local floatBorderBg = 'bg'

	if opts.float_window_style == 'auto' then
		if vim.o.winborder == 'solid' then
			floatBorderBg = 'ui'
		elseif vim.o.winborder == 'none' or vim.o.winborder == '' then
			floatBg = 'ui'
		end
	elseif opts.float_window_style == 'borderless' then
		floatBg = 'ui'
	elseif opts.float_window_style == 'solid' then
		floatBorderBg = 'ui'
	end

	--- @type table<string, vim.api.keyset.highlight>
	return {
		-- Editor
		["Normal"]     = { fg = c['tx'], bg = transparent_bg },
		["NormalNC"]   = { fg = c['tx'], bg = dim_bg },
		["NormalSB"]   = { fg = c['tx-2'], bg = c['bg-2'] },
		["NormalFloat"]    = { fg = c['tx-2'], bg = c[floatBg] },
		["FloatBorder"]    = { fg = c['tx-3'], bg = c[floatBorderBg] },
		["FloatTitle"]     = { fg = c['tx-2'], bg = c[floatBorderBg] },
		["Underlined"] = { fg = 'NONE',  bg = 'NONE', underline = true },
		["Bold"]       = { fg = 'NONE',  bg = 'NONE', bold      = true },
		["Italic"]     = { fg = 'NONE',  bg = 'NONE', italic    = true },

		-- Spelling
		["SpellBad"]   = { sp = c['re'], undercurl = true },
		["SpellCap"]   = { sp = c['ye'], undercurl = true },
		["SpellLocal"] = { sp = c['gr'], undercurl = true },
		["SpellRare"]  = { sp = c['pu'], undercurl = true },

		["NonText"]     = { fg = c['tx-3'], bg = 'NONE' },
		["EndOfBuffer"] = { fg = 'NONE', bg    = 'NONE' },

		-- Search
		["Search"]     = { fg = c['tx'], bg = c['ye'] },
		["IncSearch"]  = { fg = c['tx'], bg = c['ye'], blend = 50 },
		["CurSearch"]  = { fg = c['tx'], bg = c['ye-2'], blend = 50 },
		["Substitute"] = { fg = c['tx'], bg = c['gr'], blend = 50 },

		-- Diff. Tinted backgrounds under unchanged text, rather than a
		-- saturated fill with the background colour inverted into the text.
		["DiffAdd"]    = { bg = c['diff-add'] },
		["DiffChange"] = { bg = c['diff-change'] },
		["DiffDelete"] = { bg = c['diff-delete'] },
		["DiffText"]   = { bg = c['diff-text'] },

		-- Syntax (style-aware)
		["Comment"] = vim.tbl_extend('force', { fg = c['tx-3'], bg = 'NONE' }, opts.styles.comments or {}),

		["Constant"]  = { fg = c['ye'], bg = 'NONE' },
		["String"]    = { fg = c['cy'], bg = 'NONE' },
		["Character"] = { fg = c['cy'], bg = 'NONE' },
		["Number"]    = { fg = c['pu'], bg = 'NONE' },
		["Boolean"]   = { fg = c['ma'], bg = 'NONE' },
		["Float"]     = { fg = c['pu'], bg = 'NONE' },

		["Identifier"] = vim.tbl_extend('force', { fg = c['bl'], bg = 'NONE' }, opts.styles.variables or {}),
		["Function"]   = vim.tbl_extend('force', { fg = c['or'], bg = 'NONE' }, opts.styles.functions or {}),

		["Keyword"]     = vim.tbl_extend('force', { fg = c['gr'], bg = 'NONE' }, opts.styles.keywords or {}),
		["Statement"]   = { fg   = 'NONE',    bg = 'NONE' },
		["Conditional"] = { link = 'Keyword' },
		["Repeat"]      = { link = 'Keyword' },
		["Label"]       = { link = 'Keyword' },
		["Operator"]    = { fg   = c['tx-2'], bg = 'NONE' },
		["Exception"]   = { link = 'Keyword' },

		["PreProc"]   = { fg = c['ma'], bg = 'NONE' },
		["Include"]   = { fg = c['re'], bg = 'NONE' },
		["Define"]    = { fg = c['ma'], bg = 'NONE' },
		["Macro"]     = { fg = c['ma'], bg = 'NONE' },
		["PreCondit"] = { fg = c['ma'], bg = 'NONE' },

		["Type"]         = { fg = c['gr'],   bg = 'NONE' },
		["StorageClass"] = { fg = c['or'],   bg = 'NONE' },
		["Structure"]    = { fg = c['or'],   bg = 'NONE' },
		["Typedef"]      = { fg = c['or'],   bg = 'NONE' },

		["SpecialComment"] = { fg = c['tx'],   bg = 'NONE' },
		["Special"]        = { fg = c['tx-2'], bg = 'NONE' },
		["SpecialChar"]    = { fg = c['ma'],   bg = 'NONE' },
		["Tag"]            = { fg = c['cy'],   bg = 'NONE' },
		["Debug"]          = { fg = c['ma'],   bg = 'NONE' },
		["Delimiter"]      = { link = 'Special' },
		["Error"]          = { fg = c['re'], bg = c['bg'], bold = true },
		["Todo"]           = { fg = c['ma'], bg = 'NONE',  bold = true },

		-- UI
		["SignColumn"]     = { fg = 'NONE', bg = 'NONE' },
		["SignColumnSB"]   = { fg = c['tx-3'], bg = c['bg-2'] },
		["FoldColumn"]     = { fg = c['ui-2'], bg = c['bg-2'] },

		["MsgArea"]        = { fg = 'NONE', bg = c['bg-2'] },
		["ModeMsg"]        = { fg = 'NONE', bg = c['bg-2'] },
		["MsgSeparator"]   = { fg = 'NONE', bg = c['bg-2'] },

		-- Popup menu
		["Pmenu"]          = { fg = c['tx-2'], bg = c['bg-2'], sp = 'NONE', blend = 50 },
		["PmenuSel"]       = { fg = c['tx'],   bg = c['cy-2'] },
		["PmenuSbar"]      = { fg = 'NONE',    bg = c['ui'] },
		["PmenuThumb"]     = { fg = 'NONE',    bg = c['ui-3'] },
		["PmenuMatch"]     = { fg = c['bl'],   bg = c['bg-2'] },
		["PmenuMatchSel"]  = { fg = c['bl'],   bg = c['cy-2'] },

		-- Tabs
		["TabLine"]     = { fg = c['tx-2'], bg = c['ui'] },
		["TabLineSel"]  = { fg = c['tx'],   bg = c['ui-3'] },
		["TabLineFill"] = { fg = c['tx-3'], bg = c['ui'] },

		-- Status line
		["StatusLine"]       = { fg = c['tx'],   bg = c['ui-3'] },
		["StatusLineNC"]     = { fg = c['tx-2'], bg = c['ui'] },
		["StatusLineTerm"]   = { fg = c['tx-2'], bg = c['ui-3'] },
		["StatusLineTermNC"] = { fg = c['tx-2'], bg = c['ui-3'] },

		["WinBar"]   = { fg = c['tx'],   bg = c['ui-3'] },
		["WinBarNC"] = { fg = c['tx-2'], bg = c['ui'] },

		-- Misc UI
		["WildMenu"]       = { fg = 'NONE',    bg = c['cy-2'] },
		["Folded"]         = { fg = c['ui-2'], bg = c['bg-2'] },
		["LineNr"]         = { fg = c['tx-3'], bg = 'NONE' },
		["LineNrAbove"]    = { fg = c['tx-3'] },
		["LineNrBelow"]    = { fg = c['tx-3'] },
		["Whitespace"]     = { fg = c['tx-3'], bg = 'NONE' },
		["WinSeparator"]   = { fg = c['bg-2'], bg = c['bg-2'] },
		["WinSeparatorNC"] = { fg = c['ui-3'], bg = c['ui-3'] },
		["VertSplit"]      = { fg = c['ui'] },
		["WarningMsg"]     = { fg = c['re'],   bg = c['bg'] },
		["QuickFixLine"]   = { fg = 'NONE',    bg = c['ui'] },

		["MatchWord"]      = { fg = 'NONE', bg = c['ui'] },
		["MatchParen"]     = { fg = 'NONE', bg = c['ui'] },
		["MatchWordCur"]   = { fg = 'NONE', bg = 'NONE' },
		["MatchParenCur"]  = { fg = 'NONE', bg = 'NONE' },

		["Conceal"]   = { fg = 'NONE', bg = 'NONE' },
		["Directory"] = { fg = c['bl'], bg = 'NONE' },

		["SpecialKey"] = { fg = c['bl'],   bg = 'NONE', bold = true },
		["Title"]      = { fg = c['bl'],   bg = 'NONE', bold = true },
		["ErrorMsg"]   = { fg = c['re-2'], bg = 'NONE', bold = true },
		["MoreMsg"]    = { fg = c['or'],   bg = 'NONE' },
		["Question"]   = { fg = c['or'],   bg = 'NONE' },

		-- Cursor and selection
		["Cursor"]       = { fg = c['bg'], bg = c['tx'] },
		["lCursor"]      = { fg = c['bg'], bg = c['tx'] },
		["CursorLine"]   = { fg = 'NONE',  bg = c['ui'], blend = 65 },
		["CursorLineNr"] = { fg = c['tx'], bg = 'NONE', bold = true },
		["CursorColumn"] = { fg = 'NONE',  bg = c['bg-2'] },
		["ColorColumn"]  = { fg = 'NONE',  bg = c['ui'] },
		["CursorIM"]     = { fg = c['bg'], bg = c['tx'] },
		["TermCursor"]   = { fg = c['bg'], bg = c['tx'] },
		["TermCursorNC"] = { fg = c['bg'], bg = c['tx-3'] },
		["Visual"]       = { fg = 'NONE',  bg = c['ui-2'] },
		["VisualNOS"]    = { fg = 'NONE',  bg = c['ui-3'] },

		-- Diagnostics
		["DiagnosticError"] = { fg = c['error'] },
		["DiagnosticWarn"]  = { fg = c['warning'] },
		["DiagnosticInfo"]  = { fg = c['info'] },
		["DiagnosticHint"]  = { fg = c['hint'] },
		["DiagnosticOk"]    = { fg = c['ok'] },
		["DiagnosticUnnecessary"] = { fg = c['comment'] },

		["DiagnosticVirtualTextError"] = { fg = c['error'],   bg = c['error-bg'] },
		["DiagnosticVirtualTextWarn"]  = { fg = c['warning'], bg = c['warning-bg'] },
		["DiagnosticVirtualTextInfo"]  = { fg = c['info'],    bg = c['info-bg'] },
		["DiagnosticVirtualTextHint"]  = { fg = c['hint'],    bg = c['hint-bg'] },

		["DiagnosticUnderlineError"] = { undercurl = true, sp = c['error'] },
		["DiagnosticUnderlineWarn"]  = { undercurl = true, sp = c['warning'] },
		["DiagnosticUnderlineInfo"]  = { undercurl = true, sp = c['info'] },
		["DiagnosticUnderlineHint"]  = { undercurl = true, sp = c['hint'] },

		["DiagnosticSignError"] = { fg = c['error'] },
		["DiagnosticSignWarn"]  = { fg = c['warning'] },
		["DiagnosticSignInfo"]  = { fg = c['info'] },
		["DiagnosticSignHint"]  = { fg = c['hint'] },

		-- LSP
		["LspReferenceText"]            = { bg = c['ui'] },
		["LspReferenceRead"]            = { bg = c['ui'] },
		["LspReferenceWrite"]           = { bg = c['ui'] },
		["LspSignatureActiveParameter"] = { bg = c['ui-2'], bold = true },
		["LspCodeLens"]                 = { fg = c['tx-3'] },
		["LspInlayHint"]                = { fg = c['comment'], bg = c['hint-bg'] },

		-- Git diff (file-level)
		["Added"]   = { fg = c['git-add'] },
		["Removed"] = { fg = c['git-delete'] },
		["Changed"] = { fg = c['git-change'] },

		["diffAdded"]    = { fg = c['git-add'],    bg = c['diff-add'] },
		["diffRemoved"]  = { fg = c['git-delete'], bg = c['diff-delete'] },
		["diffChanged"]  = { fg = c['git-change'], bg = c['diff-change'] },
		["diffOldFile"]  = { fg = c['bl'], bg = c['diff-delete'] },
		["diffNewFile"]  = { fg = c['bl'], bg = c['diff-add'] },
		["diffFile"]     = { fg = c['bl'] },
		["diffLine"]     = { fg = c['comment'] },
		["diffIndexLine"] = { fg = c['ma'] },

		-- Health
		["healthError"]   = { fg = c['re'] },
		["healthSuccess"] = { fg = c['gr'] },
		["healthWarning"] = { fg = c['ye'] },

		-- Debug
		["debugBreakpoint"] = { fg = c['info'], bg = c['info-bg'] },
		["debugPC"]         = { bg = c['bg-2'] },

		-- HTML headings
		["htmlH1"] = { fg = c['ma'], bold = true },
		["htmlH2"] = { fg = c['bl'], bold = true },

		-- Quickfix
		["qfFileName"] = { fg = c['bl'] },
		["qfLineNr"]   = { fg = c['tx-3'] },

		-- Help
		["helpCommand"] = { fg = c['bl'], bg = c['ui'] },
		["helpExample"] = { fg = c['tx-3'] },
	}
end

return M
