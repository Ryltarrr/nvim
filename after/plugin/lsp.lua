local lsp = require("lsp-zero")
local luasnip = require("luasnip")

lsp.preset("recommended")
lsp.skip_server_setup({ "rust_analyzer" })

local cmp = require("cmp")
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-space>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.close()
			fallback()
		else
			cmp.complete()
		end
	end),
	-- go to next placeholder in the snippet
	["<C-g>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(1) then
			luasnip.jump(1)
		else
			fallback()
		end
	end, { "i", "s" }),
	-- go to previous placeholder in the snippet
	["<C-d>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),
})

lsp.setup_nvim_cmp({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 5 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp_mappings,
	-- to disable preselection
	-- preselect = "none",
	-- completion = {
	-- 	completeopt = "menu,menuone,noinsert,noselect",
	-- },
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})
lsp.nvim_workspace()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "<leader>vn", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "<leader>vp", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>c", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

lsp.on_attach(on_attach())
lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
local rust_lsp = lsp.build_options("rust_analyzer", {
	single_file_support = false,
	on_attach = function(client, bufnr)
		-- print("hello rust-tools")
	end,
	settings = {
		-- to enable rust-analyzer settings visit:
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			-- enable clippy on save
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

local tools = {
	runnables = {
		use_telescope = true,
	},
	inlay_hints = {
		auto = true,
		show_parameter_hints = false,
		parameter_hints_prefix = "",
		other_hints_prefix = "",
	},
}

require("rust-tools").setup({ server = rust_lsp, tools = tools })
