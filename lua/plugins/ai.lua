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
		"folke/sidekick.nvim",
		cli = {
			keys = {
				hide_ctrl_q = { "<c-q>", "hide", mode = "nt", desc = "hide the terminal window" },
			},
			picker = "fzf-lua",
		},
		keys = {
			{
				"<leader>aa",
				function()
					require("sidekick.cli").toggle({ name = "copilot", focus = true })
				end,
			},
		},
	},
}
