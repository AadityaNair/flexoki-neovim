local palette = require('flexoki.palette')
local config = require('flexoki.config')
local util = require('flexoki.util')

local M = {}

M.groups = function()
	local c = palette.palette()
	local opts = config.options

	local ret = {
		-- Legacy captures (kept for older parsers)
		['@text.literal']      = { link = 'Comment' },
		['@text.reference']    = { link = 'Identifier' },
		['@text.title']        = { link = 'Title' },
		['@text.uri']          = { link = 'Underlined' },
		['@text.underline']    = { link = 'Underlined' },
		['@text.todo']         = { link = 'Todo' },

		['@comment']           = { link = 'Comment' },
		['@punctuation']       = { link = 'Delimiter' },

		['@constant']          = { link = 'Constant' },
		['@constant.builtin']  = { link = 'Special' },
		['@constant.macro']    = { link = 'Define' },
		['@define']            = { link = 'Define' },
		['@macro']             = { link = 'Macro' },
		['@string']            = { link = 'String' },
		['@string.escape']     = { fg = c['ma'] },
		['@string.special']    = { link = 'SpecialChar' },
		['@character']         = { link = 'Character' },
		['@character.special'] = { link = 'SpecialChar' },
		['@character.printf']  = { link = 'SpecialChar' },
		['@number']            = { link = 'Number' },
		['@boolean']           = { link = 'Boolean' },
		['@float']             = { link = 'Float' },

		['@function']          = vim.tbl_extend('force', { fg = c['or'] }, opts.styles.functions or {}),
		['@function.builtin']  = { link = 'Special' },
		['@function.macro']    = { link = 'Macro' },
		['@function.call']     = { link = '@function' },
		['@function.method']   = { link = 'Function' },
		['@function.method.call'] = { link = '@function.method' },
		['@parameter']         = { link = 'Identifier' },
		['@method']            = { link = 'Function' },
		['@field']             = { link = 'Identifier' },
		['@property']          = { fg = c['bl'] },
		['@constructor']       = { fg = c['or'] },
		['@constructor.tsx']   = { fg = c['bl'] },

		['@conditional']       = { link = 'Conditional' },
		['@repeat']            = { link = 'Repeat' },
		['@label']             = { link = 'Label' },
		['@operator']          = { fg = c['tx-2'] },
		['@keyword']           = vim.tbl_extend('force', { fg = c['gr'] }, opts.styles.keywords or {}),
		['@exception']         = { link = 'Exception' },

		['@variable']          = vim.tbl_extend('force', { fg = c['tx'] }, opts.styles.variables or {}),
		['@variable.builtin']  = { fg = c['re'] },
		['@variable.member']   = { fg = c['cy'] },
		['@variable.parameter'] = { fg = c['ye'] },
		['@variable.parameter.builtin'] = { fg = c['ye-2'] },
		['@type']              = { link = 'Type' },
		['@type.builtin']      = { fg = c['gr-2'] },
		['@type.definition']   = { link = 'Typedef' },
		['@type.qualifier']    = { link = '@keyword' },
		['@storageclass']      = { link = 'StorageClass' },
		['@structure']         = { link = 'Structure' },
		['@namespace']         = { link = 'Identifier' },
		['@include']           = { link = 'Include' },
		['@preproc']           = { link = 'PreProc' },
		['@debug']             = { link = 'Debug' },
		['@tag']               = { link = 'Label' },
		['@tag.attribute']     = { link = '@property' },
		['@tag.delimiter']     = { link = 'Delimiter' },
		['@tag.tsx']           = { fg = c['re'] },
		['@tag.javascript']    = { fg = c['re'] },
		['@tag.delimiter.tsx'] = { fg = c['bl-2'] },

		-- Modern keyword captures
		['@keyword.conditional']      = { link = 'Conditional' },
		['@keyword.coroutine']        = { link = '@keyword' },
		['@keyword.debug']            = { link = 'Debug' },
		['@keyword.directive']        = { link = 'PreProc' },
		['@keyword.directive.define'] = { link = 'Define' },
		['@keyword.exception']        = { link = 'Exception' },
		['@keyword.function']         = vim.tbl_extend('force', { fg = c['ma'] }, opts.styles.functions or {}),
		['@keyword.import']           = { link = 'Include' },
		['@keyword.operator']         = { link = '@operator' },
		['@keyword.repeat']           = { link = 'Repeat' },
		['@keyword.return']           = { link = '@keyword' },
		['@keyword.storage']          = { link = 'StorageClass' },

		-- Module
		['@module']         = { link = 'Include' },
		['@module.builtin'] = { fg = c['re'] },

		-- Annotation/attribute
		['@annotation'] = { link = 'PreProc' },
		['@attribute']   = { link = 'PreProc' },

		-- Comment sub-captures
		['@comment.error']   = { fg = c['re'] },
		['@comment.hint']    = { fg = c['bl'] },
		['@comment.info']    = { fg = c['cy'] },
		['@comment.note']    = { fg = c['bl'] },
		['@comment.todo']    = { fg = c['bl'] },
		['@comment.warning'] = { fg = c['ye'] },

		-- Diff
		['@diff.delta'] = { link = 'DiffChange' },
		['@diff.minus'] = { link = 'DiffDelete' },
		['@diff.plus']  = { link = 'DiffAdd' },

		-- Punctuation
		['@punctuation.bracket']           = { fg = c['tx-2'] },
		['@punctuation.delimiter']         = { fg = c['tx-2'] },
		['@punctuation.special']           = { fg = c['tx-2'] },
		['@punctuation.special.markdown']  = { fg = c['or'] },

		-- String sub-captures
		['@string.documentation'] = { fg = c['ye'] },
		['@string.regexp']        = { fg = c['bl'] },

		-- Markup
		['@markup']                     = {},
		['@markup.emphasis']            = { italic = true },
		['@markup.environment']         = { link = 'Macro' },
		['@markup.environment.name']    = { link = 'Type' },
		['@markup.heading']             = { link = 'Title' },
		['@markup.italic']              = { italic = true },
		['@markup.link']                = { fg = c['cy'] },
		['@markup.link.label']          = { link = 'SpecialChar' },
		['@markup.link.label.symbol']   = { link = 'Identifier' },
		['@markup.link.url']            = { link = 'Underlined' },
		['@markup.list']                = { fg = c['tx-2'] },
		['@markup.list.checked']        = { fg = c['gr'] },
		['@markup.list.markdown']       = { fg = c['or'], bold = true },
		['@markup.list.unchecked']      = { fg = c['bl'] },
		['@markup.math']                = { link = 'Special' },
		['@markup.raw']                 = { link = 'String' },
		['@markup.raw.markdown_inline'] = { fg = c['bl'], bg = c['ui'] },
		['@markup.strikethrough']       = { strikethrough = true },
		['@markup.strong']              = { bold = true },
		['@markup.underline']           = { underline = true },

		['@none'] = {},
	}

	-- Rainbow heading colors for markdown
	local rainbow = { c['bl'], c['ye'], c['gr'], c['cy'], c['ma'], c['pu'], c['or'], c['re'] }
	for i, color in ipairs(rainbow) do
		ret['@markup.heading.' .. i .. '.markdown'] = {
			fg = color, bold = true, bg = util.blend(color, c['bg'], 0.1),
		}
	end

	return ret
end

return M
