return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	opts = {
		ensure_installed = {
			"lua_ls",
			"clangd",
			"css-lsp",
			"typescript-language-server",
		},
		automatic_installation = true,
	},
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "BufReadPre",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
}
