return {
	"emmanueltouzery/apidocs.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
	config = function()
		require("apidocs").setup({ picker = "ui_select" })
	end,
	keys = {
		{ "<leader>do", "<cmd>ApidocsOpen<cr>", desc = "Search Api Doc" },
		{ "<leader>di", "<cmd>ApidocsInstall<cr>", desc = "Search Api Doc" },
	},
}
