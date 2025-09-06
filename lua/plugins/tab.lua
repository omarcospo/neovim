return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slope",
					sort_by = "relative_directory",
					show_close_icon = true,
					show_buffer_close_icons = false,
				},
			})
		end,
	},
}
