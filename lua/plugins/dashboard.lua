return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			--config
			config = {
				theme = "hyper", -- theme is doom and hyper default is hyper
				header = {
					" ███████╗██╗  ██╗██╗   ██╗██╗   ██╗██╗███╗   ███╗",
					"██╔════╝██║ ██╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║",
					"███████╗█████╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║",
					"╚════██║██╔═██╗   ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
					"███████║██║  ██╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║",
					"╚══════╝╚═╝  ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝",
				},
				center = {
					{
						icon = "",
						icon_hl = "group",
						desc = "description",
						desc_hl = "group",
						key = "shortcut key in dashboard buffer not keymap !!",
						key_hl = "group",
						key_format = " [%s]", -- `%s` will be substituted with value of `key`
						action = "",
					},
				},
				footer = {},
				vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
			},
			hide = {
				statusline = true, -- hide statusline default is true
				tabline = true, -- hide the tabline
				winbar = true, -- hide winbar
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
