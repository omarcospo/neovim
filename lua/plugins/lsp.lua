return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		dependencies = {
			{ "LukasPietzschmann/boo.nvim" },
		},
		init = function()
			vim.keymap.set("n", "gd", "<cmd>lua require('boo').boo()<CR>")
			vim.keymap.set("n", "K", "<cmd>lua require('boo').boo()<CR>")
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
		end,
		config = function()
			local lsp = require("lspconfig")
			lsp.marksman.setup({})
			lsp.tinymist.setup({})
			lsp.lua_ls.setup({})
			require("lspconfig").pyright.setup({
				cmd = { vim.fn.expand("~/.local/python/bin/pyright-langserver"), "--stdio" },
				settings = {
					python = {
						pythonPath = vim.fn.expand("~/.local/python/bin/python"),
						analysis = {
							autoImportCompletions = true,
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "basic",
						},
					},
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					show_all_diags_on_cursorline = true,
					use_icons_from_diagnostic = true,
					multilines = { enabled = true, trim_whitespaces = true },
					break_line = {
						enabled = true,
						after = 30,
					},
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		version = false,
		event = "LspAttach",
		cmd = "Trouble",
		keys = {
			{ "tt", "<CMD>Trouble lsp_document_symbols toggle focus=false win.position=left filter.buf=0<CR>" },
			{ "tr", "<CMD>Trouble lsp_references toggle focus=true win.position=bottom filter.buf=0<CR>" },
			{ "td", "<CMD>Trouble diagnostics toggle focus=true win.position=top filter.buf=0<CR>" },
		},
		opts = {
			auto_close = true,
			auto_preview = true,
			auto_refresh = true,
			auto_jump = true,
			focus = true,
			restore = true,
			follow = true,
			indent_guides = false,
			max_items = 200,
			multiline = false,
			warn_no_results = false,
			open_no_results = false,
			icons = {
				indent = { middle = "", last = "", top = "", ws = "" },
			},
		},
	},
	{
		"smjonas/inc-rename.nvim",
		version = false,
		event = "LspAttach",
		config = function()
			require("inc_rename").setup({})
		end,
		keys = {
			{ "gr", ":IncRename " },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
