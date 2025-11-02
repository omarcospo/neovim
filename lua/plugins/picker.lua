return {
	{
		"ibhagwan/fzf-lua",
		version = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				"border-fused",
				fzf_colors = true,
				winopts = {
					-- border = "single",
					backdrop = 100,
					on_create = function()
						vim.keymap.set("t", "<C-q>", "<C-c>", { silent = true, buffer = true })
					end,
				},
				oldfiles = { include_current_session = true },
				previewers = { builtin = { syntax_limit_b = 1024 * 100 } },
				files = {
					prompt = "Files❯ ",
					multiprocess = true,
					cwd_header = false,
					cwd_prompt = false,
				},
				grep = {
					rg_glob = true,
					glob_flag = "--iglob",
					glob_separator = "%s%-%-",
				},
				keymap = {
					builtin = {
						["<C-i>"] = "toggle-preview",
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
				},
			})
			require("fzf-lua").register_ui_select()
			vim.keymap.set("n", "s", "<cmd>FzfLua blines<CR>", { silent = true })
			vim.keymap.set("n", "<C-s>", "<cmd>FzfLua live_grep_native<CR>", { silent = true })
			vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<CR>", { silent = true })
			vim.keymap.set("n", "<leader>hh", "<cmd>FzfLua helptags<CR>", { silent = true })
			vim.keymap.set("n", "<leader>hk", "<cmd>FzfLua keymaps<CR>", { silent = true })
			vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { silent = true })
			vim.keymap.set("n", "<leader>fd", function()
				require("fzf-lua").files({
					prompt = "$HOME ",
					cmd = "fd --type file --search-path=/home/nix",
					cwd = vim.fn.expand("%:p:h"),
				})
			end, { silent = true })
			vim.keymap.set("n", "<leader>fj", function()
				require("fzf-lua").files({
					prompt = "LS> ",
					cmd = "fd --type file",
					cwd = vim.fn.expand("%:p:h"),
				})
			end, { silent = true })
		end,
	},
	{
		"stephansama/fzf-nerdfont.nvim",
		lazy = true,
		build = ":FzfNerdfont generate",
		dependencies = { "ibhagwan/fzf-lua" },
		cmd = "FzfNerdfont",
		keys = {
			{ "<leader>fi", "<CMD>FzfNerdfont<CR>", desc = "Open fzf nerd font picker" },
		},
		---@module 'fzf-nerdfont'
		---@type FzfNerdFontOpts
		opts = {},
	},
}
