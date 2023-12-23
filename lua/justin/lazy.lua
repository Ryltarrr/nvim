local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		-- config = function()
		-- 	vim.cmd("colorscheme catppuccin-macchiato")
		-- end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-moon")
		end,
	},
	{
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.*",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<C-p>", "<cmd>Telescope git_files", desc = "git files" },
			{ "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
			{ "<leader>ft", "<cmd>Telescope grep_string<cr>", desc = "grep selection", mode = "v" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "diagnostics" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
			{ "<leader>fp", "<cmd>Telescope resume<cr>", desc = "previous" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols" },
			{
				"<leader>frc",
				"<cmd>Telescope find_files cwd=/home/justin/.config/nvim<cr>",
				desc = "find config files",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"javascript",
					"typescript",
					"tsx",
					"go",
					"rust",
					"lua",
					"vue",
					"css",
					"json",
					"prisma",
					-- "templ",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
			})
		end,
		build = ":TSUpdate",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	-- LSP related stuff
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{
		"lewis6991/gitsigns.nvim",
		-- event = "LazyFile",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = {
			{ "<leader>t", "<cmd>Neotree toggle float reveal<cr>", desc = "NeoTree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	},
	{ "simrat39/rust-tools.nvim", ft = "rust" },
	{
		"folke/trouble.nvim",
		keys = {
			{ "<leader>xx", "<cmd>Trouble<cr>", desc = "trouble open" },
			{ "<leader>xc", "<cmd>TroubleClose<cr>", desc = "trouble close" },
			{ "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "trouble workspace" },
			{ "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "trouble document" },
			{ "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "trouble quickfix" },
			{ "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "trouble loclist" },
			{ "<leader>gR", "<cmd>Trouble lsp_references<cr>", desc = "trouble lsp_references" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	event = "VeryLazy",
	-- 	init = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 300
	-- 	end,
	-- 	opts = {},
	-- },
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", "<cmd>tab Git<cr>", desc = "git dashboard" },
		},
	},
	"theprimeagen/harpoon",
	"tpope/vim-surround",
	"nvim-pack/nvim-spectre",
	"mhartington/formatter.nvim",
	-- "tpope/vim-sleuth",
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
        -- stylua: ignore
        keys = {
          { "<return>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "<s-return>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
})
