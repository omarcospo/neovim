-- keymaps
local function clean_keys(mode, prefix, keys, suffix, rhs)
	for key in keys:gmatch("<[^<>]->") do
		vim.keymap.set(mode, prefix .. key .. suffix, rhs, { nowait = true })
	end
	local single_keys = keys:gsub("<[^<>]->", "")
	for key in single_keys:gmatch(".") do
		vim.keymap.set(mode, prefix .. key .. suffix, rhs, { nowait = true })
	end
end

local ic_ctrl_G_keys = "<C-j>j<Down><C-k>k<Up>uU"
clean_keys("!", "<C-g>", ic_ctrl_G_keys, "", "<Nop>")

local ic_ctrl_X_ctrl_keys = "abcdefghijklmnopqrstuvwxyz1234567890[]"
clean_keys("!", "<C-x><C-", ic_ctrl_X_ctrl_keys, ">", "<Nop>")
clean_keys("!", "<C-x>", "s", "", "<Nop>")

local c_ctrl_R_ctrl_keys = "fpwalro"
clean_keys("c", "<C-r><C-", c_ctrl_R_ctrl_keys, ">", "<Nop>")

local ic_ctrl_keys = "@abcdefghijklmnopqrstuvwxyz[\\]^_"
clean_keys("!", "<C-", ic_ctrl_keys, ">", "<Nop>")
vim.keymap.del("!", "<Esc>")
vim.keymap.del("!", "<Cr>")
vim.keymap.del("!", "<Tab>")

local nv_q_keys = ":/?"
clean_keys({ "n", "v" }, "q", nv_q_keys, "", "<Nop>")

local vo_textobjects = "'\"()><BW[]`bpstw{}"
clean_keys("v", "i", vo_textobjects, "", "<Nop>")
clean_keys("v", "a", vo_textobjects, "", "<Nop>")
clean_keys("o", "i", vo_textobjects, "", "<Esc>")
clean_keys("o", "a", vo_textobjects, "", "<Esc>")

local nvo_marks = "`'\"^.()><[]{}0123456789"
clean_keys({ "n", "v" }, "'", nvo_marks, "", "<Nop>")
clean_keys("o", "'", nvo_marks, "", "<Esc>")
clean_keys({ "n", "v" }, "`", nvo_marks, "", "<Nop>")
clean_keys("o", "`", nvo_marks, "", "<Esc>")

local nvo_bracket_keys = "<C-d><C-i>#'()*`/DIP[]cdfimpsz{}"
clean_keys({ "n", "v" }, "[", nvo_bracket_keys, "", "<Nop>")
clean_keys({ "n", "v" }, "]", nvo_bracket_keys, "", "<Nop>")
clean_keys("o", "[", nvo_bracket_keys, "", "<Esc>")
clean_keys("o", "]", nvo_bracket_keys, "", "<Esc>")

local nvo_g_keys = "<C-a><C-g><C-h><C-]>#$&'`*+,-08;<?DEHIJNPQRTUV]^_adefFhijkmMnopqrstuvwx@~"
clean_keys({ "n", "v" }, "g", nvo_g_keys, "", "<Nop>")
clean_keys("o", "g", nvo_g_keys, "", "<Esc>")

local nv_zu_keys = "wgWG"
clean_keys({ "n", "v" }, "zu", nv_zu_keys, "", "<Nop>")
local nv_z_keys = "<Cr>1234567890+-.=ACDEFGHLMNORWX^abcdefghijklmnopPrstuvwxyz"
clean_keys({ "n", "v" }, "z", nv_z_keys, "", "<Nop>")

local n_ctrl_W_g_keys = "<C-]>}fFtT<Tab>"
clean_keys({ "n", "v" }, "<C-w>g", n_ctrl_W_g_keys, "", "<Nop>")
local n_ctrl_W_keys = "abcdefghijklmnopqrstuvwxyz+-><=]^_|}SWPRHJKLTF"
clean_keys({ "n", "v" }, "<C-w><C-", n_ctrl_W_keys, ">", "<Nop>")
clean_keys({ "n", "v" }, "<C-w>", n_ctrl_W_keys, "", "<Nop>")

local nvo_ctrl_keys = "@abcdefghjklmnpqstuwxyz\\[]^_"
clean_keys({ "n", "v" }, "<C-", nvo_ctrl_keys, ">", "<Nop>")
clean_keys("o", "<C-", nvo_ctrl_keys, ">", "<Esc>")
vim.keymap.del({ "n", "v", "o" }, "<Esc>")

local o_keys = "opaitfTF'`[]{}()vVgz,;|?HLM+-_*%#"
clean_keys("o", "", o_keys, "", "<Esc>")

local v_keys = "uoai"
clean_keys("v", "", v_keys, "", "<Nop>")

local nv_keys = " !\"#%&'()*+,-.0;><=?@FHJKLMQSTUZ[]_`fmqstz{}|~"
clean_keys({ "n", "v" }, "", nv_keys, "", "<Nop>")
