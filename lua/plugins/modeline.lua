return {
	{
		"sontungexpt/sttusline",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		branch = "table_version",
		event = { "BufEnter" },
		init = function()
			vim.opt.laststatus = 3
		end,
		config = function(_, opts)
			require("sttusline").setup({
				statusline_color = "Normal",
				disabled = {
					filetypes = {
						"lazy",
					},
					buftypes = {
						"terminal",
					},
				},
				components = {
					"mode",
					"filename",
					"git-branch",
					"%=",
					"diagnostics",
					"lsps-formatters",
				},
			})
		end,
	},
}
