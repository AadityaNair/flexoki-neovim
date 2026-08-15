local config = require('flexoki.config')

local M = {}

-- Full Flexoki palette, verbatim from the published spec:
-- https://github.com/kepano/flexoki/blob/main/css/flexoki.css
-- 14 base tones + 8 hues x 13 levels (50 ... 950).
local base_colors = {
	['flexoki-black']         = '#100F0F',
	['flexoki-paper']         = '#FFFCF0',
	['flexoki-50']            = '#F2F0E5',
	['flexoki-100']           = '#E6E4D9',
	['flexoki-150']           = '#DAD8CE',
	['flexoki-200']           = '#CECDC3',
	['flexoki-300']           = '#B7B5AC',
	['flexoki-400']           = '#9F9D96',
	['flexoki-500']           = '#878580',
	['flexoki-600']           = '#6F6E69',
	['flexoki-700']           = '#575653',
	['flexoki-800']           = '#403E3C',
	['flexoki-850']           = '#343331',
	['flexoki-900']           = '#282726',
	['flexoki-950']           = '#1C1B1A',

	['flexoki-red-50']        = '#FFE1D5',
	['flexoki-red-100']       = '#FFCABB',
	['flexoki-red-150']       = '#FDB2A2',
	['flexoki-red-200']       = '#F89A8A',
	['flexoki-red-300']       = '#E8705F',
	['flexoki-red-400']       = '#D14D41',
	['flexoki-red-500']       = '#C03E35',
	['flexoki-red-600']       = '#AF3029',
	['flexoki-red-700']       = '#942822',
	['flexoki-red-800']       = '#6C201C',
	['flexoki-red-850']       = '#551B18',
	['flexoki-red-900']       = '#3E1715',
	['flexoki-red-950']       = '#261312',

	['flexoki-orange-50']     = '#FFE7CE',
	['flexoki-orange-100']    = '#FED3AF',
	['flexoki-orange-150']    = '#FCC192',
	['flexoki-orange-200']    = '#F9AE77',
	['flexoki-orange-300']    = '#EC8B49',
	['flexoki-orange-400']    = '#DA702C',
	['flexoki-orange-500']    = '#CB6120',
	['flexoki-orange-600']    = '#BC5215',
	['flexoki-orange-700']    = '#9D4310',
	['flexoki-orange-800']    = '#71320D',
	['flexoki-orange-850']    = '#59290D',
	['flexoki-orange-900']    = '#40200D',
	['flexoki-orange-950']    = '#27180E',

	['flexoki-yellow-50']     = '#FAEEC6',
	['flexoki-yellow-100']    = '#F6E2A0',
	['flexoki-yellow-150']    = '#F1D67E',
	['flexoki-yellow-200']    = '#ECCB60',
	['flexoki-yellow-300']    = '#DFB431',
	['flexoki-yellow-400']    = '#D0A215',
	['flexoki-yellow-500']    = '#BE9207',
	['flexoki-yellow-600']    = '#AD8301',
	['flexoki-yellow-700']    = '#8E6B01',
	['flexoki-yellow-800']    = '#664D01',
	['flexoki-yellow-850']    = '#503D02',
	['flexoki-yellow-900']    = '#3A2D04',
	['flexoki-yellow-950']    = '#241E08',

	['flexoki-green-50']      = '#EDEECF',
	['flexoki-green-100']     = '#DDE2B2',
	['flexoki-green-150']     = '#CDD597',
	['flexoki-green-200']     = '#BEC97E',
	['flexoki-green-300']     = '#A0AF54',
	['flexoki-green-400']     = '#879A39',
	['flexoki-green-500']     = '#768D21',
	['flexoki-green-600']     = '#66800B',
	['flexoki-green-700']     = '#536907',
	['flexoki-green-800']     = '#3D4C07',
	['flexoki-green-850']     = '#313D07',
	['flexoki-green-900']     = '#252D09',
	['flexoki-green-950']     = '#1A1E0C',

	['flexoki-cyan-50']       = '#DDF1E4',
	['flexoki-cyan-100']      = '#BFE8D9',
	['flexoki-cyan-150']      = '#A2DECE',
	['flexoki-cyan-200']      = '#87D3C3',
	['flexoki-cyan-300']      = '#5ABDAC',
	['flexoki-cyan-400']      = '#3AA99F',
	['flexoki-cyan-500']      = '#2F968D',
	['flexoki-cyan-600']      = '#24837B',
	['flexoki-cyan-700']      = '#1C6C66',
	['flexoki-cyan-800']      = '#164F4A',
	['flexoki-cyan-850']      = '#143F3C',
	['flexoki-cyan-900']      = '#122F2C',
	['flexoki-cyan-950']      = '#101F1D',

	['flexoki-blue-50']       = '#E1ECEB',
	['flexoki-blue-100']      = '#C6DDE8',
	['flexoki-blue-150']      = '#ABCFE2',
	['flexoki-blue-200']      = '#92BFDB',
	['flexoki-blue-300']      = '#66A0C8',
	['flexoki-blue-400']      = '#4385BE',
	['flexoki-blue-500']      = '#3171B2',
	['flexoki-blue-600']      = '#205EA6',
	['flexoki-blue-700']      = '#1A4F8C',
	['flexoki-blue-800']      = '#163B66',
	['flexoki-blue-850']      = '#133051',
	['flexoki-blue-900']      = '#12253B',
	['flexoki-blue-950']      = '#101A24',

	['flexoki-purple-50']     = '#F0EAEC',
	['flexoki-purple-100']    = '#E2D9E9',
	['flexoki-purple-150']    = '#D3CAE6',
	['flexoki-purple-200']    = '#C4B9E0',
	['flexoki-purple-300']    = '#A699D0',
	['flexoki-purple-400']    = '#8B7EC8',
	['flexoki-purple-500']    = '#735EB5',
	['flexoki-purple-600']    = '#5E409D',
	['flexoki-purple-700']    = '#4F3685',
	['flexoki-purple-800']    = '#3C2A62',
	['flexoki-purple-850']    = '#31234E',
	['flexoki-purple-900']    = '#261C39',
	['flexoki-purple-950']    = '#1A1623',

	['flexoki-magenta-50']    = '#FEE4E5',
	['flexoki-magenta-100']   = '#FCCFDA',
	['flexoki-magenta-150']   = '#F9B9CF',
	['flexoki-magenta-200']   = '#F4A4C2',
	['flexoki-magenta-300']   = '#E47DA8',
	['flexoki-magenta-400']   = '#CE5D97',
	['flexoki-magenta-500']   = '#B74583',
	['flexoki-magenta-600']   = '#A02F6F',
	['flexoki-magenta-700']   = '#87285E',
	['flexoki-magenta-800']   = '#641F46',
	['flexoki-magenta-850']   = '#4F1B39',
	['flexoki-magenta-900']   = '#39172B',
	['flexoki-magenta-950']   = '#24131D',
}

-- The eight Flexoki hues, keyed by the short name used in highlights.
local hues = {
	['re'] = 'red',
	['or'] = 'orange',
	['ye'] = 'yellow',
	['gr'] = 'green',
	['cy'] = 'cyan',
	['bl'] = 'blue',
	['pu'] = 'purple',
	['ma'] = 'magenta',
}

-- Every hue gets five tiers. Flexoki's rule is that dark mode takes the
-- 400 level as its primary accent and light mode takes 600, so each tier
-- is mirrored between the two variants and the same key works in both.
--
--   X        primary accent
--   X-2      dim / secondary accent
--   X-3      bright / emphasis
--   X-bg     subtle tinted background
--   X-bg-2   stronger tinted background
local accent_tiers = {
	dark  = { [''] = 400, ['-2'] = 600, ['-3'] = 300, ['-bg'] = 950, ['-bg-2'] = 900 },
	light = { [''] = 600, ['-2'] = 400, ['-3'] = 700, ['-bg'] =  50, ['-bg-2'] = 100 },
}

--- Build the 40 accent slots (8 hues x 5 tiers) for one variant.
--- @param variant string 'dark' or 'light'
--- @return table<string, string>
local function accents(variant)
	local out = {}

	for key, hue in pairs(hues) do
		for suffix, level in pairs(accent_tiers[variant]) do
			local name = 'flexoki-' .. hue .. '-' .. level
			local color = base_colors[name]

			-- A missing level would silently become nil and break every
			-- highlight using it, so fail loudly instead.
			assert(color, 'flexoki: no such base color: ' .. name)

			out[key .. suffix] = color
		end
	end

	return out
end

local variants = {
	dark = vim.tbl_extend('error', accents('dark'), {
		_name      = 'dark',
		background = 'dark',
		['bg']     = base_colors['flexoki-black'],
		['bg-2']   = base_colors['flexoki-950'],
		['ui']     = base_colors['flexoki-900'],
		['ui-2']   = base_colors['flexoki-850'],
		['ui-3']   = base_colors['flexoki-800'],
		['tx-3']   = base_colors['flexoki-700'],
		['tx-2']   = base_colors['flexoki-500'],
		['tx']     = base_colors['flexoki-200'],
	}),
	light = vim.tbl_extend('error', accents('light'), {
		_name      = 'light',
		background = 'light',
		['bg']     = base_colors['flexoki-paper'],
		['bg-2']   = base_colors['flexoki-50'],
		['ui']     = base_colors['flexoki-100'],
		['ui-2']   = base_colors['flexoki-150'],
		['ui-3']   = base_colors['flexoki-200'],
		['tx-3']   = base_colors['flexoki-300'],
		['tx-2']   = base_colors['flexoki-600'],
		['tx']     = base_colors['flexoki-black'],
	}),
}

--- Resolve the float and border backgrounds from float_window_style.
--- Kept here rather than in a highlight module so every module that draws
--- a float agrees on the answer.
--- @param c table resolved variant
--- @return string float_bg, string border_bg
local function float_backgrounds(c)
	local style = config.options.float_window_style

	if style == 'borderless' then
		return c['ui'], c['bg']
	elseif style == 'solid' then
		return c['bg'], c['ui']
	elseif style == 'auto' then
		if vim.o.winborder == 'solid' then
			return c['bg'], c['ui']
		elseif vim.o.winborder == 'none' or vim.o.winborder == '' then
			return c['ui'], c['bg']
		end
	end

	return c['bg'], c['bg']
end

--- Semantic slots derived from the variant's colours. Everything here is
--- an alias for a spec colour -- no blending -- so that highlight modules
--- can say what a colour means instead of which hue it happens to be.
--- @param c table resolved variant
--- @return table<string, any>
local function semantics(c)
	local float_bg, float_border_bg = float_backgrounds(c)

	return {
		['none'] = 'NONE',

		-- Text
		['fg']         = c['tx'],
		['fg-dark']    = c['tx-2'],
		['fg-gutter']  = c['ui-3'],
		['fg-float']   = c['tx-2'],
		['fg-sidebar'] = c['tx-2'],
		['comment']    = c['tx-3'],

		-- Backgrounds
		['bg-float']        = float_bg,
		['bg-float-border'] = float_border_bg,
		['bg-popup']        = c['bg-2'],
		['bg-sidebar']      = c['bg-2'],
		['bg-statusline']   = c['ui-3'],
		['bg-visual']       = c['bl-bg-2'],
		['bg-search']       = c['ye-bg-2'],
		['bg-highlight']    = c['ui'],

		-- Borders
		['border']           = c['tx-3'],
		['border-highlight'] = c['bl-2'],

		-- Diagnostics
		['error']   = c['re'],
		['warning'] = c['ye'],
		['info']    = c['cy'],
		['hint']    = c['bl'],
		['ok']      = c['gr'],
		['todo']    = c['ma'],

		['error-bg']   = c['re-bg'],
		['warning-bg'] = c['ye-bg'],
		['info-bg']    = c['cy-bg'],
		['hint-bg']    = c['bl-bg'],
		['ok-bg']      = c['gr-bg'],

		-- Git status
		['git-add']    = c['gr'],
		['git-change'] = c['or'],
		['git-delete'] = c['re'],
		['git-ignore'] = c['tx-3'],

		-- Diff backgrounds
		['diff-add']    = c['gr-bg'],
		['diff-change'] = c['bl-bg'],
		['diff-delete'] = c['re-bg'],
		['diff-text']   = c['bl-bg-2'],

		-- Cycled for things like markdown heading levels. rainbow-bg holds
		-- the matching tint for each entry, by index.
		['rainbow'] = {
			c['bl'], c['ye'], c['gr'], c['cy'],
			c['ma'], c['pu'], c['or'], c['re'],
		},
		['rainbow-bg'] = {
			c['bl-bg'], c['ye-bg'], c['gr-bg'], c['cy-bg'],
			c['ma-bg'], c['pu-bg'], c['or-bg'], c['re-bg'],
		},

		-- Terminal ANSI 0-15. Normal takes the primary accent, bright takes
		-- the -3 tier, which is a genuinely lighter shade in dark mode and a
		-- deeper one in light -- so the two halves stay distinguishable
		-- instead of the bright half repeating the normal half.
		['term-0']  = c['bg'],   ['term-8']  = c['ui-3'],
		['term-1']  = c['re'],   ['term-9']  = c['re-3'],
		['term-2']  = c['gr'],   ['term-10'] = c['gr-3'],
		['term-3']  = c['ye'],   ['term-11'] = c['ye-3'],
		['term-4']  = c['bl'],   ['term-12'] = c['bl-3'],
		['term-5']  = c['ma'],   ['term-13'] = c['ma-3'],
		['term-6']  = c['cy'],   ['term-14'] = c['cy-3'],
		['term-7']  = c['tx-2'], ['term-15'] = c['tx'],
	}
end

-- Resolved palette for the current variant. Built by M.resolve(), reused by
-- every M.palette() call until M.reset() drops it.
local cache = nil

--- Build the palette for the configured variant: variant colours, then the
--- derived semantic slots, then the user's on_colors hook.
--- @return table
local function resolve()
	local name = config.options.variant

	if name == 'auto' then
		name = vim.o.background == 'dark'
			and config.options.dark_variant
			or config.options.light_variant
	else
		vim.o.background = variants[name].background
	end

	-- Copy so on_colors mutates this resolution only, not the shared table.
	local c = vim.deepcopy(variants[name])

	for key, value in pairs(semantics(c)) do
		c[key] = value
	end

	-- Runs last so it can override derived slots, not just raw hues.
	if config.options.on_colors then
		config.options.on_colors(c)
	end

	return c
end

--- Drop the cached palette. Called when the colorscheme is (re)applied so
--- that config and background changes take effect.
M.reset = function()
	cache = nil
end

--- @return table
M.palette = function()
	if not cache then
		cache = resolve()
	end

	return cache
end

return M
