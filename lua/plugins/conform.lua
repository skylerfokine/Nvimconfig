return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				ocaml = { "ocamlformat" },
				sql = { "sql_formatter" },
				-- Add more formatters for other file types as needed
			},
			-- Optional: Configure format on save
			format_on_save = {
				lsp_fallback = true, -- Fallback to LSP if no specific formatter is found
				async = false,
				timeout_ms = 500,
			},
		})
	end,
}
