vim.o.title = true
vim.o.cmdheight = 0
vim.o.showcmd = false
vim.o.ruler = false
vim.o.inccommand = "split"
vim.opt.fillchars = { eob = " " }
vim.opt.shortmess:append("filnxtToOFWcC")
--- Session
vim.o.autochdir = true
vim.o.swapfile = false
vim.g.big_file = { size = 1024 * 100, lines = 10000 }
vim.g.autoread = true
vim.o.showtabline = 0
--- Split
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
--- Mouse
vim.g.mousemoveement = true
---- Typing
vim.o.updatetime = 250
---- History
vim.o.history = 100
--- Wraping
vim.o.wrap = false
vim.o.colorcolumn = "80"
--- Indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.preserveindent = true
--- Copy/Paste
vim.opt.clipboard = "unnamed,unnamedplus"
vim.o.copyindent = true
vim.o.virtualedit = "block"
--- Scrolling
vim.o.lazyredraw = false
vim.o.scrolloff = 1000
vim.o.sidescrolloff = 8
vim.o.smoothscroll = true
vim.o.mousescroll = "ver:1,hor:0"
--- Highlighting
vim.o.synmaxcol = 240
vim.o.conceallevel = 3
--- Gutter Signs
vim.o.signcolumn = "yes"
vim.o.numberwidth = 3
--- Line Numbers
vim.o.number = true
--- Undo
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.config/nvim/.undo")
--- Backups
vim.o.backup = false
vim.o.writebackup = false
--- CursosLine
vim.o.cursorline = false
vim.o.showmode = false
--- Neovide
vim.o.linespace = 0
if vim.g.neovide then
	vim.o.guifont = "Iosevka Nerd Font:h15:#h-slight"
	vim.g.neovide_theme = "dark"
	vim.g.neovide_fullscreen = false

	vim.g.neovide_cursor_trail_size = 0.4
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_unlink_border_highlights = true

	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_scroll_animation_far_lines = 5

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_floating_shadow = false
	vim.g.neovide_floating_blur_amount_y = 0.0
	vim.g.neovide_floating_blur_amount_x = 0.0

	vim.keymap.set("n", "<sc-v>", 'l"+P', { noremap = true })
	vim.keymap.set("v", "<sc-v>", '"+P', { noremap = true })
	vim.keymap.set("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
	vim.keymap.set("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
		vim.cmd("redraw!")
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.05)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.05)
	end)
end
---- Python
vim.g.python3_host_prog = vim.fn.expand("~/.local/python/bin/python")
---- Other filetypes
vim.filetype.add({ extension = { typ = "typst" } })
---- End of line
vim.o.selection = "old"
-- clean mappings
vim.o.timeoutlen = 500
---- Set <leader> key to <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = "n"
vim.filetype.add({ filename = { [".zshrc"] = "sh", ["config"] = "json" } })
