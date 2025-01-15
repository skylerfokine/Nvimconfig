require("config.lazy")

-- Pane Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right
-- Window Management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Vertically
vim.keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split Horizontally
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimise

--Execution bindings
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")--executes the source command for curent file
vim.keymap.set("n", "<space>x", ":.lua<CR>")--executes the current line as lua code
vim.keymap.set("v", "<space>x", ":lua<CR>")--executes the selected visual block
-- Directory Navigation
vim.keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
-- Link acessesing
vim.api.nvim_set_keymap(
  "n",
  "gx",
  [[:silent execute '!cmd.exe /C start firefox ' . shellescape(expand('<cfile>'), 1)<CR>]],
  { noremap = true, silent = true }
)

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
