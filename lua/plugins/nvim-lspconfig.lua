return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
	},
	-- define which LSP servers you want, and any per‐server opts
	opts = {
		servers = {
			lua_ls = {},
			-- tsserver = {},
			-- pyright  = { settings = { python = { ... } } },
		},
	},
	-- one config function that lazy.nvim will call with (_, opts)
	config = function(_, opts)
		local lspconfig = require("lspconfig")

		for server, server_opts in pairs(opts.servers) do
			-- merge blink.cmp’s LSP capabilities into each server’s opts
			server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)

			-- finally, call the setup
			lspconfig[server].setup(server_opts)
		end
	end,
}
