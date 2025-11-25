return {
	-- Pane Navigation
	vim.keymap.set("n", "<C-h>", "<C-w>h"), -- Navigate Left
	vim.keymap.set("n", "<C-j>", "<C-w>j"), -- Navigate Down
	vim.keymap.set("n", "<C-k>", "<C-w>k"), -- Navigate Up
	vim.keymap.set("n", "<C-l>", "<C-w>l"), -- Navigate Right

	-- Find and replace
	vim.keymap.set("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true }),

	--Buffer Navigation
	vim.keymap.set("n", "bb", ":BufferLineCycleNext<CR>"),
	vim.keymap.set("n", "bB", ":BufferLineCycleNext<CR>"),
	vim.keymap.set("n", "mb", ":BufferLineMoveNext<CR>"),
	vim.keymap.set("n", "mB", ":BufferLineMovePrev<CR>"),
	vim.keymap.set("n", "bc", ":BufferLinePickClose<CR>"),

	-- Window Management
	vim.keymap.set("n", "<leader>sv", ":vsplit<CR>"), -- Split Vertically
	vim.keymap.set("n", "<leader>sh", ":split<CR>"), -- Split Horizontally
	vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>"), -- Toggle Minimise

	--Execution bindings
	vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>"), --executes the source command for curent file
	vim.keymap.set("n", "<space>x", ":.lua<CR>"), --executes the current line as lua code
	vim.keymap.set("v", "<space>x", ":lua<CR>"), --executes the selected visual block
	vim.keymap.set("n", "<space>et", "<cmd>tab split<CR>"), -- full screen the current window
	vim.keymap.set("n", "<space>te", "<cmd>tabc<CR>"), -- close the current window
	vim.api.nvim_set_keymap("n", "<leader>ng", ":Neogen<CR>", { noremap = true, silent = true }), -- run neogen
	vim.api.nvim_set_keymap("n", "<leader>tt", ":terminal<CR>", { noremap = true, silent = true }),

	-- Directory Navigation
	vim.keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true }),
	vim.keymap.set("n", "<leader>ot", ":NvimTreeToggle<CR>", { noremap = true, silent = true }),
	vim.keymap.set("n", "<leader>gg", ":Flogsplit<CR>", { noremap = true, silent = true }),
	-- Link acessesing
	vim.api.nvim_set_keymap(
		"n",
		"gx",
		[[:silent execute '!cmd.exe /C start firefox ' . shellescape(expand('<cfile>'), 1)<CR>]],
		{ noremap = true, silent = true }
	),

	-- Resize splits with arrow keys
	vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true }),

	-- Comments
	vim.api.nvim_set_keymap("n", "<C-_>", "gtc", { noremap = false }),
	vim.api.nvim_set_keymap("v", "<C-_>", "goc", { noremap = false }),

	-- AI keymaps
	-- === CodeCompanion: ChatGPT-style keymaps ===

	-- 1) Quick Ask (opens chat and sends your prompt)
	vim.keymap.set("n", "<leader>aa", function()
		vim.ui.input({ prompt = "Ask AI: " }, function(msg)
			if msg and #msg > 0 then
				vim.cmd("CodeCompanionChat " .. msg)
			end
		end)
	end, { desc = "AI: Ask (chat)" }),

	-- 2) Toggle chat panel (like opening ChatGPT)
	vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI: Toggle chat" }),

	-- 3) Explain selected code (visual) – immediate answer in a new buffer
	vim.keymap.set("v", "<leader>ae", ":'<,'>CodeCompanion /explain<CR>", { desc = "AI: Explain selection" }),

	-- 4) Fix/improve selected code (visual)
	vim.keymap.set("v", "<leader>af", ":'<,'>CodeCompanion /fix<CR>", { desc = "AI: Fix this codes" }),

	-- 5) “Talk about this file” (adds current buffer as context automatically)
	vim.keymap.set("n", "<leader>ab", function()
		vim.cmd("CodeCompanionChat Could you explain what this file does. Use #{buffer}.")
	end, { desc = "AI: Ask about current buffer" }),

	-- Optional: add the selection to the chat thread quickly
	vim.keymap.set("v", "<leader>ad", ":'<,'>CodeCompanionChat Add<CR>", { desc = "AI: Add selection to chat" }),
	-- 6) “Generates test cases” (adds current buffer as context automatically)
	vim.keymap.set("v", "<leader>ag", ":'<,'>CodeCompanion /tests<CR>", { desc = "AI: Generate Test cases" }),

	-- Highlight when yanking (copying) text
	--  Try it with `yap` in normal mod
	--  See `:help vim.highlight.on_yank()`
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	}),
}
