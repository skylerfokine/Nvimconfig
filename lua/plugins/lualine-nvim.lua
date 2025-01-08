local config = function()
	local theme = require("lualine.themes.catppuccin")

	require("lualine").setup({
		options = {
			theme = theme,
			globalstatus = true,
		},
		tabline = {},
		sections = {
    	lualine_a = { "mode" },
			lualine_b = { "buffers" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
    },
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
