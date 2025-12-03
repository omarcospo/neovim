return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			local filetypes = {
				-- #general
				"python",
				-- #go
				"go",
				"gomod",
				"gotmpl",
				-- #web
				"html",
				"css",
				-- #docs
				"typst",
				"markdown_inline",
				"markdown",
				-- #configs
				"vimdoc",
				"vim",
				"luap",
				"luadoc",
				"lua",
				"bash",
				-- #infos
				"toml",
				"yaml",
				"xml",
				"json",
			}
			---@diagnostic disable-next-line
			treesitter.setup({
				ensure_installed = filetypes,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		version = false,
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
				},
			})
		end,
	},
	{
		"Jay-Madden/auto-fix-return.nvim",
		config = function()
			require("auto-fix-return").setup({})
		end,
	},
}
