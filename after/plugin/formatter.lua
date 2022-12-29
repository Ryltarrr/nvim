local prettier = require("formatter.defaults.prettier")
local api = vim.api

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,
		},
		typescript = {
			prettier,
		},
		json = {
			prettier,
		},
		javascript = {
			prettier,
		},
		typescriptreact = {
			prettier,
		},
		javascriptreact = {
			prettier,
		},
		svelte = {
			prettier,
		},
		prisma = {
			prettier,
		},
		go = {
			require("formatter.filetypes.go").gofumpt,
		},
		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- Highlight on yank
local formatGroup = api.nvim_create_augroup("FormatAutoGroup", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
	command = "FormatWrite",
	group = formatGroup,
})
