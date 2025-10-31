pcall(function()
	vim.loader.enable()
end)
vim.deprecate = function() end -- Disable deprecation warnings
----------------------
vim.opt.shell = "zsh"
vim.g.no_plugin_maps = 1
vim.g.loaded_zipPlugin = 0
vim.g.loaded_zip = 0
vim.g.loaded_tutor_mode_plugin = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_tar = 0
vim.g.loaded_spellfile_plugin = 0
vim.g.loaded_shada_plugin = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_remote_plugins = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_matchit = 0
vim.g.loaded_man = false
vim.g.loaded_gzip = 0
vim.g.loaded_2html_plugin = 0
vim.g.editorconfig = false
if vim.g.vscode then
	require("config.vscode")
else
	require("config.clean")
	require("config.mappings")
	require("config.autocmds")
end

local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/" .. "/customs/", "*.lua", false, true)
for _, file in ipairs(files) do
	local module_name = file:match(".*/(.*)%.lua$")
	local success, err = pcall(require, "/customs/" .. "." .. module_name)
	if not success then
		vim.notify("Error requiring " .. module_name .. ": " .. err, vim.log.levels.ERROR)
	end
end
