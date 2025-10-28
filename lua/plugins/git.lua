return {
	{
		"echasnovski/mini.diff",
		version = false,
		opts = {
			view = { style = "sign", signs = { add = " ▎", change = " ▎", delete = " ▎" } },
			mappings = { apply = "gh", reset = "gH" },
		},
		config = function(_, opts)
			require("mini.diff").setup(opts)
			vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#00ff00", bold = true })
			vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#3f51b5", bold = true })
			vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#ff0000", bold = true })
		end,
	},
	{
		"NeogitOrg/neogit",
		version = false,
		keys = {
			{ "<leader>gg", "<CMD>Neogit<CR>" },
		},
		config = function()
			require("neogit").setup({
				disable_hint = true,
				disable_context_highlighting = true,
				auto_refresh = true,
				kind = "vsplit",
				auto_show_console = false,
				auto_close_console = true,
				commit_editor = { kind = "split", show_staged_diff = false },
				signs = {
					hunk = { "", "" },
					item = { " ", " " },
					section = { " ", " " },
				},
				commit_select_view = { kind = "split" },
				commit_view = { kind = "split", verify_commit = false },
				rebase_editor = { kind = "split" },
				reflog_view = { kind = "split" },
				merge_editor = { kind = "split" },
				tag_editor = { kind = "split" },
				log_view = { kind = "split" },
				popup = { kind = "split" }, -- keymaps
				mappings = {
					popup = {
						["p"] = "PushPopup",
						["P"] = "PullPopup",
					},
				},
			})
		end,
	},
}
