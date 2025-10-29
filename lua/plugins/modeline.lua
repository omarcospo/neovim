return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "BufEnter" },
		init = function()
			vim.opt.laststatus = 3
		end,
		config = function(_, opts)
			-- Improved lualine config with taller statusline
			local lualine = require("lualine")

			-- Get colors from current colorscheme
			local function get_colors()
				-- Try to get colors from the current colorscheme
				local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
				local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
				local comment_fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg

				-- Fallback colors if colorscheme doesn't define them
				return {
					bg = normal_bg and string.format("#%06x", normal_bg) or "#202328",
					fg = normal_fg and string.format("#%06x", normal_fg) or "#bbc2cf",
					comment_fg = comment_fg and string.format("#%06x", comment_fg) or "#5C6370",
					-- Get colors from common highlight groups
					red = vim.api.nvim_get_hl(0, { name = "Error" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Error" }).fg)
						or "#ec5f67",
					green = vim.api.nvim_get_hl(0, { name = "String" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "String" }).fg)
						or "#98be65",
					yellow = vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg)
						or "#ECBE7B",
					blue = vim.api.nvim_get_hl(0, { name = "Function" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Function" }).fg)
						or "#51afef",
					magenta = vim.api.nvim_get_hl(0, { name = "Identifier" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Identifier" }).fg)
						or "#c678dd",
					cyan = vim.api.nvim_get_hl(0, { name = "Type" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Type" }).fg)
						or "#008080",
					orange = vim.api.nvim_get_hl(0, { name = "Constant" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Constant" }).fg)
						or "#FF8800",
					violet = vim.api.nvim_get_hl(0, { name = "Special" }).fg
							and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Special" }).fg)
						or "#a9a1e1",
				}
			end

			local colors = get_colors()

			-- Cache frequently used functions
			local fn = vim.fn

			-- Simplified conditions
			local conditions = {
				buffer_not_empty = function()
					return fn.empty(fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return fn.winwidth(0) > 80
				end,
				has_git = function()
					return vim.b.gitsigns_head or vim.g.loaded_gitsigns_nvim
				end,
			}

			-- Mode colors lookup table - using colors from theme

			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					theme = "auto", -- Use auto theme detection
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Helper functions with direct table insertion (more efficient)
			local function add_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			local function add_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			-- NVIM MODE - Taller with more padding
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}
			add_left({
				function()
					local mode_names = {
						n = "NORMAL",
						i = "INSERT",
						v = "VISUAL",
						[""] = "V-BLOCK",
						V = "V-LINE",
						c = "COMMAND",
						no = "N-OP",
						s = "SELECT",
						S = "S-LINE",
						[""] = "S-BLOCK",
						ic = "INSERT",
						R = "REPLACE",
						Rv = "V-REPLACE",
						cv = "COMMAND",
						ce = "COMMAND",
						r = "PROMPT",
						rm = "MORE",
						["r?"] = "CONFIRM",
						["!"] = "SHELL",
						t = "TERMINAL",
					}
					return mode_names[fn.mode()] or "NORMAL"
				end,

				fg = colors.fg,
				color = function()
					return { bg = mode_color[vim.fn.mode()] }
				end,
				gui = "bold",
			})

			-- File components with increased padding
			add_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.comment_fg, gui = "bold" },
				symbols = { modified = " ●", readonly = " 🔒" },
			})

			-- Git branch with increased padding
			add_left({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})

			-- Mini.diff integration for git stats with increased padding
			add_left({
				function()
					if not package.loaded["mini.diff"] then
						return ""
					end

					local mini_diff = require("mini.diff")
					local summary = mini_diff.get_buf_data(0) or {}
					local counts = summary.summary or {}

					local added = counts.add or 0
					local modified = counts.change or 0
					local removed = counts.delete or 0

					if added + modified + removed == 0 then
						return ""
					end

					-- Compact symbols only (when there are changes)
					local parts = {}
					if added > 0 then
						table.insert(parts, string.format("󰜄 %d", added))
					end
					if modified > 0 then
						table.insert(parts, string.format("󱗝 %d", modified))
					end
					if removed > 0 then
						table.insert(parts, string.format("󰍵 %d", removed))
					end

					return table.concat(parts, " ")
				end,
				color = { fg = colors.orange },
				cond = conditions.hide_in_width,
			})

			-- Center spacer
			add_left({
				function()
					return "%=%="
				end,
			})

			-- Diagnostics with increased padding
			add_right({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.cyan },
					hint = { fg = colors.blue },
				},
			})

			-- LSP info with increased padding
			add_right({
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					return #clients > 0 and clients[1].name or "No LSP"
				end,
				icon = " ",
				color = { fg = colors.yellow, gui = "bold" },
			})

			lualine.setup(config)
		end,
	},
}
