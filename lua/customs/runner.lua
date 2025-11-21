local function find_go_projects(search_dir)
	search_dir = search_dir or "~/Projects"
	search_dir = vim.fn.expand(search_dir)

	local projects = {}
	local handle = io.popen('find "' .. search_dir .. '" -name "go.mod" -type f 2>/dev/null')
	if not handle then
		return projects
	end

	for line in handle:lines() do
		local project_dir = vim.fn.fnamemodify(line, ":h")
		local project_name = vim.fn.fnamemodify(project_dir, ":t")
		table.insert(projects, {
			name = project_name,
			path = project_dir,
		})
	end
	handle:close()
	return projects
end

local function execute_go_command(project_path, command)
	if not command then
		vim.ui.input({
			prompt = "Enter custom Go command: ",
			default = "go ",
		}, function(input)
			if input and input ~= "" then
				execute_go_command(project_path, input)
			end
		end)
		return
	end

	local term_cmd = string.format("cd %s && %s", vim.fn.shellescape(project_path), command)
	vim.api.nvim_create_autocmd("TermOpen", {
		callback = function()
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
		end,
	})
	vim.cmd("split | terminal " .. term_cmd)
end

local function select_command_ui(project)
	local commands = {
		{ name = "go run", cmd = "go run .", desc = "Run the project" },
		{ name = "go build", cmd = "go build", desc = "Build the project" },
		{ name = "go test", cmd = "go test ./...", desc = "Run all tests" },
		{ name = "go test -v", cmd = "go test -v ./...", desc = "Run tests with verbose output" },
		{ name = "go mod tidy", cmd = "go mod tidy", desc = "Tidy dependencies" },
		{ name = "go clean", cmd = "go clean", desc = "Clean build artifacts" },
		{ name = "go install", cmd = "go install", desc = "Install the binary" },
		{ name = "custom command", cmd = nil, desc = "Enter custom command" },
	}

	local items = {}
	for _, cmd in ipairs(commands) do
		table.insert(items, {
			text = cmd.name,
			desc = cmd.desc,
			cmd = cmd.cmd,
		})
	end

	vim.ui.select(items, {
		prompt = "Select Go command for: " .. project.name,
		format_item = function(item)
			return string.format("%s - %s", item.text, item.desc)
		end,
	}, function(selected)
		if selected then
			execute_go_command(project.path, selected.cmd)
		end
	end)
end

local function select_project_ui()
	local projects = find_go_projects()

	if #projects == 0 then
		vim.notify("No Go projects found", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, project in ipairs(projects) do
		table.insert(items, {
			text = project.name,
			desc = project.path,
			project = project,
		})
	end

	vim.ui.select(items, {
		prompt = "Select Go project:",
		format_item = function(item)
			return string.format("%s (%s)", item.text, item.desc)
		end,
	}, function(selected)
		if selected then
			select_command_ui(selected.project)
		end
	end)
end

local function run_current_project()
	local current_dir = vim.fn.getcwd()
	local go_mod_path = current_dir .. "/go.mod"

	if vim.fn.filereadable(go_mod_path) == 1 then
		execute_go_command(current_dir, "go run .")
	else
		vim.notify("Not in a Go project directory", vim.log.levels.ERROR)
	end
end

-- Keymaps
vim.keymap.set("n", "<leader>rm", select_project_ui, { desc = "Manage Go projects" })
vim.keymap.set("n", "<leader>rr", run_current_project, { desc = "Run current Go project" })
