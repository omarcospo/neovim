-- Create new note
local function new_note()
	vim.cmd("edit " .. vim.fn.trim(vim.fn.system({ "sh", "-c", "zk new -p" })))
end

local function list_notes()
	vim.cmd("FzfLua files cwd='~/Documents/Notes/'")
end

vim.keymap.set("n", "<leader>in", new_note, { desc = "New note" })
vim.keymap.set("n", "<leader>il", list_notes, { desc = "List note" })
-- vim.keymap.set("n", "<leader>zf", find_note, { desc = "Find note" })
-- vim.keymap.set("n", "<leader>zg", grep_notes, { desc = "Grep notes" })
-- vim.keymap.set("n", "<leader>zl", insert_link, { desc = "Insert link" })
