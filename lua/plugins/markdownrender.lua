-- lua/plugins/markview.lua
return {
	"OXY2DEV/markview.nvim",
	opts = {
		experimental = {
			check_rtp = true, -- keep fixing the load order
			check_rtp_message = false, -- silence the warning
		},
		preview = { filetypes = { "markdown", "codecompanion" } },
	},
}
