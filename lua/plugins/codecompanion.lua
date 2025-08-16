return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	opts = {
		-- Make Ollama the default for both strategies
		strategies = {
			chat = {
				adapter = "ollama",
				-- nice defaults for the chat buffer
				keymaps = {
					send = { modes = { n = "<CR>", i = "<C-s>" } }, -- send
					close = { modes = { n = "<C-c>", i = "<C-c>" } }, -- close
				},
			},
			inline = { adapter = "ollama" },
		},

		-- Tune the Ollama adapter + default model
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					-- change the default model here (pick a size your GPU/RAM can handle)
					schema = {
						model = { default = "qwen2.5-coder:7b" }, -- or :14b / :32b / :latest
						-- num_ctx etc. are available too if you want
					},
					-- opts = { stream = true }, -- streaming responses (default on)
				})
			end,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
