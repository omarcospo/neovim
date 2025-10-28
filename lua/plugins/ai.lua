return {

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "copilot",
			windows = {
				width = 40,
				sidebar_header = { enabled = false },
				ask = { floating = true, border = "single" },
			},
			mappings = {
				sidebar = {
					-- apply_all = "A",
					-- apply_cursor = "a",
					-- retry_user_request = "r",
					-- edit_user_request = "e",
					-- switch_windows = "<Tab>",
					-- reverse_switch_windows = "<S-Tab>",
					-- remove_file = "d",
					-- add_file = "@",
					close = { "<Esc>", "q", "<C-q>", "<C-c>" },
					close_from_input = { normal = "<Esc>", insert = "<C-q>" },
				},
			},
			behaviour = { auto_approve_tool_permissions = { "replace_in_file" } },
			input = { provider = "dressing" },
			selector = { provider = "fzf" },
		},
		init = function()
			vim.keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<cr>")
			vim.keymap.set("n", "<leader>ac", "<cmd>AvanteToggle<cr>")
		end,
	},
}
