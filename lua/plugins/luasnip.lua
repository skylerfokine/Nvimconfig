return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*", 
  build = "make install_jsregexp", 
  function config()
    require("luasnip").setup{ enable_autosnippets = }
}
