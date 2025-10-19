return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				custom_highlights = {
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
