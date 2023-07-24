local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

keymap({ "n", "v" }, "<C-A-j>", "<ESC>:res +5<CR>")
keymap({ "n", "v" }, "<C-A-k>", "<ESC>:res -5<CR>")
keymap({ "n", "v" }, "<C-A-h>", "<ESC>:vertical resize -5<CR>")
keymap({ "n", "v" }, "<C-A-l>", "<ESC>:vertical resize +5<CR>")
keymap("i", "<C-A-j>", "<ESC>:res +5<CR>i")
keymap("i", "<C-A-k>", "<ESC>:res -5<CR>i")
keymap("i", "<C-A-h>", "<ESC>:vertical resize -5<CR>i")
keymap("i", "<C-A-l>", "<ESC>:vertical resize +5<CR>i")

keymap({ "n", "v" }, "<C-l>", "<ESC><C-w>l")
keymap({ "n", "v" }, "<C-h>", "<ESC><C-w>h")
keymap({ "n", "v" }, "<C-j>", "<ESC><C-w>j")
keymap({ "n", "v" }, "<C-k>", "<ESC><C-w>k")
keymap("i", "<C-l>", "<ESC><C-w>l<CR>i")
keymap("i", "<C-h>", "<ESC><C-w>h<CR>i")
keymap("i", "<C-j>", "<ESC><C-w>j<CR>i")
keymap("i", "<C-k>", "<ESC><C-w>k<CR>i")

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Paste
keymap("n", "]p", "o<Esc>p", { desc = "Paste below" })
keymap("n", "]P", "O<Esc>p", { desc = "Paste above" })

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap({ "n", "v" }, "y", [["+y]])
keymap("n", "<A-d>", "YP")
keymap("i", "<A-d>", "<ESC>YPi")

-- Insert blank line
keymap("n", "]<Space>", "o<Esc>")
keymap("n", "[<Space>", "O<Esc>")

keymap("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })

-- Auto indent
keymap("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })
