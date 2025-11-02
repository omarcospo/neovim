return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				follow_current_file = { enabled = true, leave_dirs_open = true },
				use_default_mappings = false,
				window = {
					position = "left",
					width = 30,
					mapping_options = { noremap = true, nowait = true },
					mappings = {
						["<C-q>"] = "cancel",
						["l"] = "open",
						["h"] = "close_node",
						["<C-h>"] = "close_all_nodes",
						["<C-l>"] = "expand_all_nodes",
						["P"] = { "toggle_preview", config = { use_float = true } },
						["s"] = "open_vsplit",
						["<C-s>"] = "open_split",
						["f"] = "fuzzy_finder",
						["<C-f>"] = "clear_filter",
						["a"] = { "add", config = { show_path = "none" } },
						["A"] = "add_directory",
						["d"] = "delete",
						["<C-r>"] = "rename",
						["r"] = "rename_basename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy",
						["m"] = "move",
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
						["i"] = "show_file_details",
					},
					fuzzy_finder_mappings = {
						["<C-q>"] = "close",
						["<C-f>"] = "close_keep_filter",
						["<C-j>"] = "move_cursor_down",
						["<C-k>"] = "move_cursor_up",
					},
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["gU"] = "git_undo_last_commit",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
							["o"] = {
								"show_help",
								nowait = false,
								config = { title = "Order by", prefix_key = "o" },
							},
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree<CR>", { desc = "Toggle file explorer" })
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					vim.cmd("Neotree")
				end,
			})
		end,
	},
}
