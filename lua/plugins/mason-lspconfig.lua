return {
	"williamboman/mason-lspconfig.nvim",
	-- Let Lazy handle deps first; don't add events here.
	dependencies = {
		{
			"williamboman/mason.nvim",
			-- Make sure Mason is initialized *before* mason-lspconfig runs.
			lazy = false,
			config = function()
				require("mason").setup({
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				})
			end,
		},
	},
	lazy = false,
	opts = {
		ensure_installed = {
			"lua_ls",
			"clangd",
			"cssls",
			"ts_ls",
			"html",
		},
		automatic_installation = true,
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
	end,
}
