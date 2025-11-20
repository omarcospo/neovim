vim.o.cmdheight = 0
--- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.preserveindent = true
--- Copy/Paste
vim.opt.clipboard = "unnamedplus"
vim.opt.copyindent = true
vim.opt.virtualedit = "block"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local function map(mode, key, action)
	vim.keymap.set(mode, key, ":call VSCodeNotify('" .. action .. "')<CR>")
end
map("n", "<leader><leader>", "workbench.action.showCommands")
--- File
map("n", "<leader>fs", "workbench.action.files.save")
map({ "n", "x" }, "<leader>wj", "workbench.action.navigateDown")
map({ "n", "x" }, "<leader>wk", "workbench.action.navigateUp")
map({ "n", "x" }, "<leader>wh", "workbench.action.navigateLeft")
map({ "n", "x" }, "<leader>wl", "workbench.action.navigateRight")
---- Goto begin and end of line
vim.keymap.set("n", "<C-l>", "$")
vim.keymap.set("n", "<C-h>", "0")
---- Move lines
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==")
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv")
---- Comenting
vim.keymap.set("n", "gco", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>")
vim.keymap.set("n", "gcO", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>")
---- Format and wrap
vim.keymap.set("v", "w", ":'<,'>!fmt -80<CR>")
---- Add thing at end of line
function Add_at_end(char)
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.cmd("norm A" .. char)
	vim.api.nvim_win_set_cursor(0, cursor)
end
vim.keymap.set("n", ";", ":lua Add_at_end(';')<CR>")
vim.keymap.set("n", ",", ":lua Add_at_end(',')<CR>")
vim.keymap.set("n", ".", ":lua Add_at_end('.')<CR>")
vim.keymap.set({ "i", "v" }, "<C-q>", "<Esc>")
