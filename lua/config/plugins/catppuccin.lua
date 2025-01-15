return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy =  false,
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
        })
        -- Apply the color scheme
        vim.cmd.colorscheme "catppuccin"
    end,
}

