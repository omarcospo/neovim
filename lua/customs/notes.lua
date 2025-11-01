-- Create new note
function CreateRandomMarkdown()
	local chars = "abcdefghijklmnopqrstuvwxyz0123456789"
	local name = ""
	for i = 1, 4 do
		local rand = math.random(1, #chars)
		name = name .. chars:sub(rand, rand)
	end
	local filepath = "~/Documents/Notes/" .. name .. ".md"
	vim.cmd("edit " .. filepath)
	vim.cmd("w!")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, { "# " })
	vim.cmd("startinsert!")
end

local function list_notes()
	vim.cmd("FzfLua live_grep cwd='~/Documents/Notes/'")
end

function InsertNoteLinks(file)
	local name = vim.fn.fnamemodify(file, ":t:r")
	local link = "[" .. name .. "](" .. file .. ")"
	vim.api.nvim_put({ link }, "l", true, true)
end

function SelectNoteFile()
	opts = opts or {}
	opts.actions = {
		["default"] = function(selected, opts)
			InsertNoteLinks(selected[1]:match("([^:]*):"))
		end,
	}
	opts.cwd = "~/Documents/Notes/"
	opts.previewer = "builtin"
	opts.fn_transform = function(x)
		return FzfLua.make_entry.file(x, opts)
	end
	return FzfLua.fzf_live(function(args)
		return "rg -t md  --column --color=always -- " .. vim.fn.shellescape(args[1] or "")
	end, opts)
end

function FollowMdLink()
	local line = vim.api.nvim_get_current_line()
	local filepath = line:match("%[.-%]%((.-)%)")
	if filepath and vim.fn.filereadable(filepath) == 1 then
		vim.cmd("edit " .. filepath)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "cr", function()
			FollowMdLink()
		end, { buffer = true, desc = "Follow markdown link" })
	end,
})

vim.keymap.set("n", "<leader>im", FollowMdLink, { desc = "List note" })
vim.keymap.set("n", "<leader>in", CreateRandomMarkdown, { desc = "New note" })
vim.keymap.set("n", "<leader>il", list_notes, { desc = "List note" })
vim.keymap.set("n", "<leader>ii", SelectNoteFile, { desc = "List note" })
