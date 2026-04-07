local c = require('flexoki.palette').palette()

local flexoki = {}

flexoki.normal = {
	a = { bg = c['bl'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['bl'] },
	c = { bg = c['ui'], fg = c['tx-2'] },
}

flexoki.insert = {
	a = { bg = c['gr'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['gr'] },
}

flexoki.command = {
	a = { bg = c['ye'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['ye'] },
}

flexoki.visual = {
	a = { bg = c['ma'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['ma'] },
}

flexoki.replace = {
	a = { bg = c['re'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['re'] },
}

flexoki.terminal = {
	a = { bg = c['cy'], fg = c['bg'], gui = 'bold' },
	b = { bg = c['ui-3'], fg = c['cy'] },
}

flexoki.inactive = {
	a = { bg = c['ui'], fg = c['bl'] },
	b = { bg = c['ui'], fg = c['tx-3'], gui = 'bold' },
	c = { bg = c['ui'], fg = c['tx-3'] },
}

return flexoki
