require("config.lazy")

-- Pane Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h") -- Navigate Left
vim.keymap.set("n", "<C-j>", "<C-w>j") -- Navigate Down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- Navigate Up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- Navigate Right
-- Window Management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>") -- Split Vertically
vim.keymap.set("n", "<leader>sh", ":split<CR>") -- Split Horizontally
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- Toggle Minimise

--Execution bindings
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") --executes the source command for curent file
vim.keymap.set("n", "<space>x", ":.lua<CR>") --executes the current line as lua code
vim.keymap.set("v", "<space>x", ":lua<CR>") --executes the selected visual block
vim.keymap.set("n", "<space>et", "<cmd>tab split<CR>") -- full screen the current window
vim.keymap.set("n", "<space>te", "<cmd>tabc<CR>") -- close the current window
vim.api.nvim_set_keymap("n", "<leader>ng", ":Neogen<CR>", { noremap = true, silent = true }) -- run neogen
vim.api.nvim_set_keymap("n", "<leader>ot", ":Lspsaga term_toggle<CR>", { noremap = true, silent = true })

-- Directory Navigation
vim.keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", function()
	vim.cmd(":NvimTreeToggle<CR>")
	-- Add a delay of 100 milliseconds to give time for the tree to open.
	vim.defer_fn(function()
		vim.cmd(":Flogsplit")
	end, 100)
end, { noremap = true, silent = true })

-- Link acessesing
vim.api.nvim_set_keymap(
	"n",
	"gx",
	[[:silent execute '!cmd.exe /C start firefox ' . shellescape(expand('<cfile>'), 1)<CR>]],
	{ noremap = true, silent = true }
)

-- Resize splits with arrow keys
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gtc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "goc", { noremap = false })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mod
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
