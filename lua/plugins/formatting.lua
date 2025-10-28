return {
	"stevearc/conform.nvim",
	version = false,
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
				typst = { "typstyle" },
				nix = { "alejandra" },
			},
		})
	end,
}
