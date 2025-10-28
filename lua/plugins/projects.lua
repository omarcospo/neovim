return {
	"DrKJeff16/project.nvim",
	version = false, -- Get the latest release
	dependencies = { "ibhagwan/fzf-lua" },
	---@module 'project'

	---@type Project.Config.Options
	opts = {},
	config = function()
		require("project").setup()
	end,
	vim.keymap.set("n", "<leader>pp", "<cmd>ProjectFzf<CR>", { silent = true }),
}
