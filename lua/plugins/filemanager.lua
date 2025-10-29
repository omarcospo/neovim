return {
	{
		"mikavilpas/yazi.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = { { "<leader>ff", "<cmd>Yazi<cr>" } },
		opts = {
			open_for_directories = false,
			floating_window_scaling_factor = 0.7,
			yazi_floating_window_border = "single",
			highlight_hovered_buffers_in_same_directory = false,
			keymaps = {
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-h>",
				show_help = false,
				copy_relative_path_to_selected_files = false,
				grep_in_directory = false,
				replace_in_directory = false,
				cycle_open_buffers = false,
				open_file_in_tab = false,
				send_to_quickfix_list = false,
				change_working_directory = false,
				open_and_pick_window = false,
			},
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},
}
