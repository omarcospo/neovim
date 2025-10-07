return {
	{
		"timantipov/md-table-tidy.nvim",
		opts = { padding = 1, key = "m" },
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = "markdown",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
