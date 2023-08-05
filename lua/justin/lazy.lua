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
		config = function()
			vim.cmd("colorscheme catppuccin-macchiato")
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
			{ "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "live grep", mode = "v" },
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
		build = ":TSUpdate",
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup({})
		end,
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
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = {
			{ "<leader>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
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
			{ "<leader>xx", "<cmd>TroubleClose<cr>", desc = "trouble close" },
			{ "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "trouble workspace" },
			{ "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "trouble document" },
			{ "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "trouble quickfix" },
			{ "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "trouble loclist" },
			{ "<leader>gR", "<cmd>Trouble lsp_references<cr>", desc = "trouble lsp_references" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint,
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", "<cmd>tab Git<cr>", desc = "git dashboard" },
		},
	},
	"theprimeagen/harpoon",
	"tpope/vim-surround",
	"mhartington/formatter.nvim",
	"tpope/vim-sleuth",
})
