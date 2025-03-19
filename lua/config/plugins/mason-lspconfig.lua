return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	opts = {
		ensure_installed = {
			"angularls",
			"efm",
			"lua_ls",
			"pyright",
			"jsonls",
			"clangd",
			"emmet_ls",
		},
		automatic_installation = true,
	},
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
