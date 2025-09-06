return {
	"HiPhish/rainbow-delimiters.nvim",
	version = false,
	event = { "BufEnter" },
	dependencies = { "monkoose/matchparen.nvim" },
	config = function()
		require("matchparen").setup()
		require("rainbow-delimiters.setup").setup()
	end,
}
