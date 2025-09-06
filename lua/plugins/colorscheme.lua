return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			require("gruvbox").setup({
				overrides = {
					StatusLine = { bg = "#181617" },
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
				},
				dim_inactive = false,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
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
