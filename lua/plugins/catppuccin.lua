return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
			transparent_background = false,
			term_colors = true,

			color_overrides = {
				mocha = { -- Applies to the "mocha" flavor
					base = "#000000", -- Set the base color (background) to black
					mantle = "#000000",
					crust = "#000000",
				},
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			custom_highlights = function(C)
				return {
					-- Window split borders
					WinSeparator = { fg = "#3399ff" },
					VertSplit = { fg = "#3399ff" },

					-- Floating window borders
					FloatBorder = { fg = "#3399ff", bg = C.base },
					NormalFloat = { bg = C.base },

					-- Common plugin borders (optional)
					TelescopeBorder = { fg = "#3399ff" },
					LspInfoBorder = { fg = "#3399ff" },
					NoicePopupBorder = { fg = "#3399ff" },
				}
			end,
		})
		-- Apply the color scheme
		vim.cmd.colorscheme("catppuccin")
	end,
}
