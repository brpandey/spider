return {
	{
		"rose-pine/neovim",
		name = "rose-pine-dawn",
		priority = 500,
		config = function()
			vim.cmd("colorscheme rose-pine-dawn")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-wave",
		priority = 500,
		config = function()
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-dragon",
		priority = 500,
		config = function()
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-lotus",
		priority = 500,
		config = function()
			vim.cmd("colorscheme kanagawa-lotus")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-dark",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 500, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd("colorscheme github_dark")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-light",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 500, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd("colorscheme github_light")
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin-latte",
		priority = 500,
		config = function()
			vim.cmd("colorscheme catppuccin-latte")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin-frappe",
		priority = 500,
		config = function()
			vim.cmd("colorscheme catppuccin-frappe")
		end,
	},
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 500, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		-- "folke/tokyonight.nvim",
		"sainnhe/everforest",
		name = "everforest",
		priority = 1000, -- Make sure to load this before all the other start plugins.

		init = function()
			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=italic")

			vim.g.everforest_background = "medium"
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_better_performance = 1

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			-- vim.o.background = "dark" -- "light"
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "everforest dark",
						colorscheme = "everforest",
						before = [[
						-- All this block will be executed before apply "set colorscheme"
						vim.opt.background = "dark"
					]],
					},
					{
						name = "everforest light",
						colorscheme = "everforest",
						before = [[
						vim.opt.background = "light"
					]],
						after = [[-- Same as before, but after if you need it]],
					},
					{
						name = "tokyonight light",
						colorscheme = "tokyonight",
						before = [[
						vim.opt.background = "light"
					]],
						after = [[-- Same as before, but after if you need it]],
					},
					{
						name = "tokyonight dark",
						colorscheme = "tokyonight",
						before = [[
						vim.opt.background = "dark"
					]],
						after = [[-- Same as before, but after if you need it]],
					},

					--					"tokyonight",
					"kanagawa-wave",
					"kanagawa-dragon",
					"kanagawa-lotus",
					"catppuccin-latte",
					"catppuccin-frappe",
					"rose-pine-dawn",
					"github_dark",
					"github_light",
				},

				--				themes = { "everforest", "tokyonight", "rose-pine-dawn" }, -- Your list of installed colorschemes.
				livePreview = true, -- Apply theme while picking. Default to true.
			})
		end,
	},
}
