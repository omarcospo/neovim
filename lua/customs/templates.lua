local project_templates = {
	dotnet = {
		templates = { "console", "classlib", "mstest", "xunit", "web", "mvc", "webapi" },
		command = function(template, project_dir)
			return "dotnet new " .. template .. " -o " .. project_dir
		end,
		default_dir = "~/Projects/",
	},
	node = {
		templates = { "express", "react", "vue", "angular", "svelte", "nextjs" },
		command = function(template, project_dir)
			local commands = {
				express = "npx express-generator " .. project_dir,
				react = "npx create-react-app " .. project_dir,
				vue = "npx @vue/cli create " .. project_dir .. " --default",
				angular = "npx @angular/cli new " .. project_dir .. " --routing=true --style=css",
				svelte = "npx degit sveltejs/template " .. project_dir,
				nextjs = "npx create-next-app@latest " .. project_dir .. " --typescript --tailwind --eslint --app",
			}
			return commands[template] or "echo 'Unknown template'"
		end,
		default_dir = "~/Projects/",
	},
	python = {
		templates = { "flask", "django", "fastapi", "cli" },
		command = function(template, project_dir)
			local commands = {
				flask = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && python -m venv venv && echo 'Flask project created'",
				django = "django-admin startproject myproject " .. project_dir,
				fastapi = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && python -m venv venv && echo 'FastAPI project created'",
				cli = "mkdir -p "
					.. project_dir
					.. " && cd "
					.. project_dir
					.. " && python -m venv venv && echo 'CLI project created'",
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

				Project_dir = config.default_dir .. project_name

				-- Build and execute command
				local cmd = config.command(template, Project_dir)
				vim.cmd("new")
				vim.fn.jobstart({ "sh", "-c", cmd }, {
					rpc = false,
					term = true,
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
