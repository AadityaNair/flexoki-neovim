local M = {}

M.groups = function()
	--- @type table<string, vim.api.keyset.highlight>
	return {
		-- Deprecated LSP diagnostic names (compatibility with older plugins)
		["LspDiagnosticsDefaultError"]       = { link = "DiagnosticError" },
		["LspDiagnosticsDefaultWarning"]     = { link = "DiagnosticWarn" },
		["LspDiagnosticsDefaultInformation"] = { link = "DiagnosticInfo" },
		["LspDiagnosticsDefaultHint"]        = { link = "DiagnosticHint" },
	}
end

return M
