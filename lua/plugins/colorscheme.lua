return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "",
				overrides = {
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
				},
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
