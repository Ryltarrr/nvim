require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"javascript",
		"typescript",
		"tsx",
		"go",
		"rust",
		"lua",
		"php",
		"vue",
		"css",
		"json",
		"prisma",
	},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
})
