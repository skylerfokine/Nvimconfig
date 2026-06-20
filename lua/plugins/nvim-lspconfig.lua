-- lua/plugins/nvim-lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		-- LSP capabilities (blink.cmp)
		local caps = require("blink.cmp").get_lsp_capabilities()

		-- on_attach with Telescope (falls back to native LSP if Telescope is absent)
		local function on_attach(_, bufnr)
			local map = function(m, lhs, rhs, desc)
				vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			local has_tb, tb = pcall(require, "telescope.builtin")
			if has_tb then
				map("n", "gd", tb.lsp_definitions, "LSP: definitions (Telescope)")
				map("n", "gr", tb.lsp_references, "LSP: references (Telescope)")
				map("n", "gi", tb.lsp_implementations, "LSP: implementations (Telescope)")
				map("n", "gt", tb.lsp_type_definitions, "LSP: type defs (Telescope)")
			else
				map("n", "gd", vim.lsp.buf.definition, "LSP: definition")
				map("n", "gr", vim.lsp.buf.references, "LSP: references")
				map("n", "gi", vim.lsp.buf.implementation, "LSP: implementation")
				map("n", "gt", vim.lsp.buf.type_definition, "LSP: type definition")
			end

			map("n", "K", vim.lsp.buf.hover, "Hover docs")
			-- use IncRename so it matches the global keymaps.lua binding
			vim.keymap.set("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { buffer = bufnr, silent = true, expr = true, desc = "Rename symbol (IncRename)" })
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		end

		-- helpers
		local util = require("lspconfig.util")
		local ocaml_root = util.root_pattern("dune-project", "dune-workspace", "*.opam", ".git")

		---------------------------------------------------------------------------
		-- Lua_ls
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

		---------------------------------------------------------------------------
		-- SQL
		---------------------------------------------------------------------------

		vim.lsp.config("sqlls", {
			capabilities = caps,
			on_attach = on_attach,
			filetypes = { "sql", "mysql" },
			cmd = { "sql-language-server", "up", "--method", "stdio" },
			single_file_support = true,
		})

		---------------------------------------------------------------------------
		-- Typescript javascript
		---------------------------------------------------------------------------

		local mason_tsserver = vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server"

		vim.lsp.config("ts_ls", {
			capabilities = caps,
			on_attach = on_attach,

			cmd = { mason_tsserver, "--stdio" },

			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},

			root_markers = {
				"package.json",
				"package-lock.json",
				"tsconfig.json",
				"jsconfig.json",
				".git",
			},

			workspace_required = true,
			single_file_support = false,
		})

		---------------------------------------------------------------------------
		-- CSS and HTML
		---------------------------------------------------------------------------

		vim.lsp.config("cssls", { capabilities = caps, on_attach = on_attach })
		vim.lsp.config("html", { capabilities = caps, on_attach = on_attach })

		---------------------------------------------------------------------------
		-- Python via Pyright
		---------------------------------------------------------------------------

		vim.lsp.config("pyright", {
			capabilities = caps,
			on_attach = on_attach,
		})

		---------------------------------------------------------------------------
		-- OCaml via Mason ONLY
		---------------------------------------------------------------------------
		local mason_ocamllsp = vim.fn.stdpath("data") .. "/mason/bin/ocamllsp"
		if vim.fn.filereadable(mason_ocamllsp) ~= 1 then
			vim.schedule(function()
				vim.notify(
					"Mason ocamllsp not found at " .. mason_ocamllsp .. ". Open :Mason and install 'ocamllsp'.",
					vim.log.levels.ERROR
				)
			end)
		end

		vim.lsp.config("ocamllsp", {
			capabilities = caps,
			on_attach = on_attach,
			cmd = { mason_ocamllsp },
			filetypes = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },

			root_dir = function(fname, bufnr)
				local start = fname
				if type(bufnr) == "number" then
					local n = vim.api.nvim_buf_get_name(bufnr)
					if n and n ~= "" then
						start = n
					end
				end
				if type(start) ~= "string" or start == "" then
					return nil
				end
				return ocaml_root(start) or vim.fs.dirname(start) or vim.loop.cwd()
			end,

			single_file_support = true,
		})

		---------------------------------------------------------------------------
		-- C++ Language server
		---------------------------------------------------------------------------

		vim.lsp.config("clangd", {
			capabilities = caps,
			on_attach = on_attach,
		})

		---------------------------------------------------------------------------
		-- Enable servers
		---------------------------------------------------------------------------
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("cssls")
		vim.lsp.enable("html")
		vim.lsp.enable("ocamllsp")
		vim.lsp.enable("clangd")
		vim.lsp.enable("sqlls")
		vim.lsp.enable("pyright")

		---------------------------------------------------------------------------
		-- Safety net: ensure ocamllsp attaches even if auto-start didn't fire
		---------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },
			callback = function(args)
				if #vim.lsp.get_clients({ buf = args.buf, name = "ocamllsp" }) > 0 then
					return
				end
				if vim.fn.filereadable(mason_ocamllsp) ~= 1 then
					return
				end
				local fname = vim.api.nvim_buf_get_name(args.buf)
				if fname == "" then
					return
				end
				vim.lsp.start({
					name = "ocamllsp",
					cmd = { mason_ocamllsp },
					root_dir = ocaml_root(fname) or vim.fs.dirname(fname) or vim.loop.cwd(),
					get_language_id = function()
						return "ocaml"
					end,
				})
			end,
		})

		-- Handy manual command for ad-hoc buffers: :OCamlLspHere
		vim.api.nvim_create_user_command("OCamlLspHere", function()
			if vim.fn.filereadable(mason_ocamllsp) ~= 1 then
				return vim.notify("Mason ocamllsp not found: " .. mason_ocamllsp, vim.log.levels.ERROR)
			end
			local name = vim.api.nvim_buf_get_name(0)
			if name == "" then
				return vim.notify("Save the file first so I can pick a root.", vim.log.levels.WARN)
			end
			vim.lsp.start({
				name = "ocamllsp",
				cmd = { mason_ocamllsp },
				root_dir = vim.fs.dirname(name),
				get_language_id = function()
					return "ocaml"
				end,
			})
		end, {})

		---------------------------------------------------------------------------
		-- Diagnostics
		---------------------------------------------------------------------------
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = { spacing = 2, source = "if_many" },
			float = { border = "rounded", source = "if_many" },
		})
	end,
}
