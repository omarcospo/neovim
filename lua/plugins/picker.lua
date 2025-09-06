return {
	"ibhagwan/fzf-lua",
	version = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				on_create = function()
					vim.keymap.set("t", "<C-q>", "<C-c>", { silent = true, buffer = true })
				end,
				border = "single",
				preview = {
					layout = "vertical",
					title = false,
					vertical = "down:70%",
				},
			},
			keymap = {
				builtin = {
					["<C-i>"] = "toggle-preview",
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
			},
			keymaps = {
				winopts = { preview = { vertical = "down:5%" } },
			},
		})
		vim.keymap.set("n", "s", "<cmd>FzfLua blines<CR>", { silent = true })
		vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<CR>", { silent = true })
		vim.keymap.set("n", "<leader>a", "<cmd>FzfLua lgrep_curbuf<CR>", { silent = true })
		vim.keymap.set("n", "<leader>s", "<cmd>FzfLua live_grep<CR>", { silent = true })
		vim.keymap.set("n", "<leader>hh", "<cmd>FzfLua helptags<CR>", { silent = true })
		vim.keymap.set("n", "<leader>hk", "<cmd>FzfLua keymaps<CR>", { silent = true })
		vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { silent = true })
	end,
}
