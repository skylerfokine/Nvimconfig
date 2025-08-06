return {
	{ "lewis6991/gitsigns.nvim", lazy = false },
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for icons
		config = function()
			require("bufferline").setup({
				-- Your configuration options here
				options = {
					-- ...
				},
			})
		end,
	},
}
