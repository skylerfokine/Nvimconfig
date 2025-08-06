return {
	"danymat/neogen",
	lazy = false,
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				cpp = {
					template = {
						annotation_convention = "doxygen", -- Use Doxygen for C++
					},
				},
				python = {
					template = {
						annotation_convention = "google", -- Example for Python
					},
				},
				lua = {
					template = {
						annotation_convention = "ldoc", -- Example for Lua
					},
				},
			},
		})
	end,
	version = "*", -- Use the latest stable version
}
