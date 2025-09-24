-- lua/plugins/nvim-lspconfig.lua
-- Requires: neovim/nvim-lspconfig, williamboman/mason.nvim,
--           williamboman/mason-lspconfig.nvim, saghen/blink.cmp

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local caps = require("blink.cmp").get_lsp_capabilities()

		local function on_attach(_, bufnr)
			local map = function(m, lhs, rhs)
				vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true })
			end
			map("n", "gd", vim.lsp.buf.definition)
			map("n", "gr", vim.lsp.buf.references)
			map("n", "K", vim.lsp.buf.hover)
			map("n", "<leader>rn", vim.lsp.buf.rename)
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		end

		-- We still use root_pattern helpers from lspconfig.util
		local util = require("lspconfig.util")
		local dirname = vim.fs.dirname
		local ocaml_root = util.root_pattern("dune-project", "dune-workspace", "*.opam", ".git")

		---------------------------------------------------------------------------
		-- Register servers (new API)
		---------------------------------------------------------------------------
		vim.lsp.config("lua_ls", {
			capabilities = caps,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		vim.lsp.config("ts_ls", {
			capabilities = caps,
			on_attach = on_attach,
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			cmd = { "typescript-language-server", "--stdio" },
		})

		vim.lsp.config("cssls", { capabilities = caps, on_attach = on_attach })
		vim.lsp.config("html", { capabilities = caps, on_attach = on_attach })

		-- OCaml with robust root_dir and fs.dirname
		vim.lsp.config("ocamllsp", {
			capabilities = caps,
			on_attach = on_attach,
			cmd = { vim.fn.exepath("ocamllsp") }, -- Mason or opam
			filetypes = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },
			root_dir = function(fname, bufnr)
				-- Prefer buffer path if available, then filename; always fall back to dirname
				local start = fname
				if type(bufnr) == "number" then
					local n = vim.api.nvim_buf_get_name(bufnr)
					if n and n ~= "" then
						start = n
					end
				end
				return ocaml_root(start) or (start and dirname(start))
			end,
		})

		---------------------------------------------------------------------------
		-- Enable servers
		---------------------------------------------------------------------------
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("cssls")
		vim.lsp.enable("html")
		vim.lsp.enable("ocamllsp")

		---------------------------------------------------------------------------
		-- Diagnostics (optional)
		---------------------------------------------------------------------------
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = { spacing = 2, source = "if_many" }, -- ok
			float = {
				border = "rounded",
				-- pick ONE of these:
				-- source = true,
				source = "if_many",
			},
		})
	end,
}
