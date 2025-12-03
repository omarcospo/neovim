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
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.rename()
			end, { desc = "LSP Rename" })
			vim.lsp.config("pyright", {
				cmd = { vim.fn.expand("~/.local/python/bin/pyright-python-langserver"), "--stdio" },
				settings = {
					python = {
						pythonPath = vim.fn.expand("~/.local/python/bin/python"),
						analysis = {
							autoImportCompletions = true,
							ignore = { "*" },
							logLevel = "Error",
							typeCheckingMode = "off",
						},
					},
				},
			})
			vim.lsp.config("ruff", {
				cmd = { vim.fn.expand("~/.local/python/bin/ruff"), "server" },
				settings = {
					interpreter = vim.fn.expand("~/.local/python/bin/python"),
					organizeImports = true,
				},
			})
			vim.lsp.enable("pyright")
			vim.lsp.enable("ruff")
			vim.lsp.enable("tinymist")
			vim.lsp.enable("lua_ls")
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						hints = {
							rangeVariableTypes = true,
							parameterNames = true,
							constantValues = true,
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							functionTypeParameters = true,
						},
					},
				},
			})
			vim.lsp.enable("gopls")
		end,
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {},
		config = function()
			-- default settings
			require("lsp-endhints").setup({
				icons = {
					type = "󰜁 ",
					parameter = "󰏪 ",
					offspec = " ", -- hint kind not defined in official LSP spec
					unknown = " ", -- hint kind is nil
				},
				label = {
					truncateAtChars = 20,
					padding = 1,
					marginLeft = 0,
					sameKindSeparator = ", ",
				},
				extmark = {
					priority = 50,
				},
				autoEnableHints = true,
			})
		end,
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
}
