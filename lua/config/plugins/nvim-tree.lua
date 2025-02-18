return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	auto_reload_on_write = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})
	end,
}
