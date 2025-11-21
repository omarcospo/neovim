local project_templates = {
	python = {
		templates = { "cli" },
		command = function(template, project_dir)
			local commands = {
				cli = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && touch main.py && git init && echo 'CLI project created with git'",
			}
			return commands[template] or "echo 'Unknown template'"
		end,
		default_dir = "~/Projects/",
	},
	go = {
		templates = { "cli", "web", "module" },
		command = function(template, project_dir)
			local commands = {
				cli = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && go mod init "
					.. project_dir:match("([^/]+)$")
					.. " && touch main.go && git init && echo 'Go CLI project created with git'",
				web = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && go mod init "
					.. project_dir:match("([^/]+)$")
					.. " && touch main.go && git init && echo 'Go web project created with git'",
				module = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && go mod init "
					.. project_dir:match("([^/]+)$")
					.. " && git init && echo 'Go module created with git'",
			}
			return commands[template] or "echo 'Unknown template'"
		end,
		default_dir = "~/Projects/",
	},
}

local function create_project()
	-- Select language/framework
	local languages = {}
	for lang, _ in pairs(project_templates) do
		table.insert(languages, lang)
	end

	vim.ui.select(languages, { prompt = "Language/Framework: " }, function(language)
		if not language then
			return
		end

		local config = project_templates[language]

		-- Get project name
		vim.ui.input({ prompt = "Project name: " }, function(project_name)
			if not project_name or project_name == "" then
				return
			end

			-- Select template
			vim.ui.select(config.templates, { prompt = "Template: " }, function(template)
				if not template then
					return
				end

				local Project_dir = config.default_dir .. project_name

				-- Build and execute command
				local cmd = config.command(template, Project_dir)
				vim.cmd("new")
				vim.fn.jobstart({ "sh", "-c", cmd }, {
					rpc = false,
					term = true,
					on_exit = function()
						-- Set Neovim's current working directory to the new project
						vim.schedule(function()
							-- Expand ~ to full path if present
							local expanded_dir = Project_dir:gsub("^~", os.getenv("HOME"))
							vim.cmd("cd " .. vim.fn.fnameescape(expanded_dir))
							print("Current working directory set to: " .. expanded_dir)
						end)
					end,
					on_stdout = function()
						vim.cmd("startinsert")
					end,
				})
			end)
		end)
	end)
end

-- You can also create individual commands for each language if desired
vim.api.nvim_create_user_command("ProjectNew", create_project, {})
vim.keymap.set("n", "<leader>o", "<CMD>ProjectNew<CR>")
