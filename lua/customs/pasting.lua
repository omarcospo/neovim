function InsertMarkdownURL()
	local url = vim.fn.getreg("+")
	if url == "" then
		print("No URL in clipboard")
		return
	end

	-- Get page title using curl
	local handle = io.popen("curl -s -L " .. vim.fn.shellescape(url) .. " 2>/dev/null")
	if not handle then
		print("Failed to fetch URL")
		return
	end

	local html = handle:read("*a")
	handle:close()

	-- Extract title from HTML
	local title = html:match("<title>(.-)</title>") or ""
	title = title:gsub("[\r\n]", ""):gsub("^%s*(.-)%s*$", "%1") -- Clean up whitespace

	if title == "" then
		print("Title not found for URL")
		return
	end

	-- Create and insert markdown link
	local markdown_link = "[" .. title .. "](" .. url .. ")"
	local line = vim.api.nvim_get_current_line()

	-- Insert at current line (replacing if empty, appending if not)
	if line:match("^%s*$") then
		vim.api.nvim_set_current_line(markdown_link)
	else
		vim.api.nvim_put({ markdown_link }, "l", true, true)
	end
end

vim.keymap.set("n", "ç", InsertMarkdownURL, { silent = true, noremap = true })
