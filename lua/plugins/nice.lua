return {
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.6, -- 0.45     [0, 1]
			stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			damping = 0.95, -- 0.85     [0, 1]
			damping_insert_mode = 0.95, -- 0.9      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0
			time_interval = 7, -- milliseconds
		},
	},
	{
		"rcarriga/nvim-notify",
		version = false,
		lazy = true,
		opts = {
			background_colour = "Normal",
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			minimum_width = 30,
			max_height = 10,
			render = "wrapped-compact",
			stages = "static",
			timeout = 3000,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
	{
		"stevearc/dressing.nvim",
		version = false,
		lazy = true,
		opts = {},
	},
	{
		"folke/noice.nvim",
		version = false,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				presets = { inc_rename = true },
				background_color = "#161616",
				messages = { enabled = true },
				lsp = {
					hover = { enabled = false },
					signature = { enabled = false },
					progress = { enabled = false },
					message = { enabled = false },
					smart_move = { enabled = false },
				},
				cmdline = {
					opts = { border = { style = "single" } },
				},
			})
		end,
	},
}
