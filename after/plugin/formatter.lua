local prettierd = require("formatter.defaults.prettierd")
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
			prettierd,
		},
		json = {
			prettierd,
		},
		html = {
			prettierd,
		},
		javascript = {
			prettierd,
		},
		typescriptreact = {
			prettierd,
		},
		javascriptreact = {
			prettierd,
		},
		svelte = {
			prettierd,
		},
		prisma = {
			prettierd,
		},
		go = {
			require("formatter.filetypes.go").gofumpt,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
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

-- Format current buffer using LSP.
api.nvim_create_autocmd({
	-- 'BufWritePre' event triggers just before a buffer is written to file.
	"BufWritePre",
}, {
	pattern = { "*.templ" },
	callback = function()
		-- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
		vim.lsp.buf.format()
	end,
})
