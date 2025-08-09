return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		require("luasnip").setup({ enable_autosnippets = true })
		require("luasnip.loaders.from_vscode").lazy_load()

		local map = vim.keymap.set
		map({ "i", "s" }, "<Tab>", function(fallback)
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				fallback()
			end
		end, { silent = true, expr = true })
		map({ "i", "s" }, "<S-Tab>", function(fallback)
			if ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { silent = true, expr = true })
	end,
}
