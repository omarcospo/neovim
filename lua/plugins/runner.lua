return {
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
	},
	{
		"Vigemus/iron.nvim",
		ft = "python",
		config = function()
			local iron = require("iron.core")
			local view = require("iron.view")
			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						sh = { command = { "zsh" } },
						python = {
							command = { vim.g.python3_host_prog, "-q" },
							format = require("iron.fts.common").bracketed_paste,
							block_deviders = { "# %%", "#%%" },
						},
					},
					repl_open_cmd = view.split.vertical.botright("40%"),
				},
				keymaps = {
					send_file = "<localleader>sf",
					send_line = "<localleader>sl",
					send_paragraph = "<localleader>sp",
					send_mark = "<localleader>sm",
					mark_motion = "<localleader>mc",
					mark_visual = "<localleader>mc",
					remove_mark = "<localleader>md",
					exit = "<localleader>sq",
					clear = "<localleader>sc",
				},
				highlight = {
					italic = true,
				},
				ignore_blank_lines = false,
			})
			vim.keymap.set("n", "<localleader>rs", "<cmd>IronRepl<cr>")
			vim.keymap.set("n", "<localleader>rr", "<cmd>IronRestart<cr>")
			vim.keymap.set("n", "<localleader>rf", "<cmd>IronFocus<cr>")
			vim.keymap.set("n", "<localleader>rh", "<cmd>IronHide<cr>")
		end,
	},
}
