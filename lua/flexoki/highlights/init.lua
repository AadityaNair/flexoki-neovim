local M = {}

M.groups = function ()

	local modules = {
		-- Core
		require('flexoki.highlights.base').groups(),
		require('flexoki.highlights.treesitter').groups(),
		require('flexoki.highlights.semantic-tokens').groups(),
		require('flexoki.highlights.kinds').groups(),
		require('flexoki.highlights.lsp').groups(),

		-- Git
		require('flexoki.highlights.git').groups(),

		-- Plugin suites
		require('flexoki.highlights.mini-nvim').groups(),

		-- Navigation/motion
		require('flexoki.highlights.flash-nvim').groups(),

		-- File explorers
		require('flexoki.highlights.neotree').groups(),
		require('flexoki.highlights.nvim-tree').groups(),

		-- Completion
		require('flexoki.highlights.blink').groups(),
		require('flexoki.highlights.cmp').groups(),

		-- UI
		require('flexoki.highlights.noice').groups(),
		require('flexoki.highlights.notify').groups(),
		require('flexoki.highlights.buffer').groups(),
		require('flexoki.highlights.indent-blank-line').groups(),
		require('flexoki.highlights.treesitter-context').groups(),
		require('flexoki.highlights.todo-comments').groups(),
		require('flexoki.highlights.dashboard').groups(),

		-- Syntax
		require('flexoki.highlights.markdown').groups(),

		-- Misc
		require('flexoki.highlights.telescope').groups(),
		require('flexoki.highlights.whichkey').groups(),
	}

	--- @type table<string, vim.api.keyset.highlight>
	local result = {}

	for _, groups in pairs(modules) do
		for highlightGroup, group in pairs(groups) do
			result[highlightGroup] = group
		end
	end

	return result
end

return M
