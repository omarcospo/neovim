return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = { "fang2hou/blink-copilot", "rafamadriz/friendly-snippets" },
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-f>"] = { "select_and_accept" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "normal",
			},
			sources = {
				default = { "lazydev", "lsp", "copilot", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						min_keyword_length = 0,
					},
				},
			},
			completion = {
				menu = {
					min_width = 10,
					max_height = 10,
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					draw = { align_to = "cursor" },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = {
						min_width = 10,
						max_width = 100,
						max_height = 20,
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
