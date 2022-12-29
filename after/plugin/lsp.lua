local lsp = require("lsp-zero")

lsp.preset("recommended")

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
})

lsp.setup_nvim_cmp({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 5 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp_mappings,
})
lsp.nvim_workspace()
lsp.setup()

vim.keymap.set("n", "<leader>c", function()
	vim.lsp.buf.code_action()
end, {})
vim.keymap.set("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, {})
vim.keymap.set("n", "<leader>vn", function()
	vim.diagnostic.goto_next()
end, {})
vim.keymap.set("n", "<leader>vp", function()
	vim.diagnostic.goto_prev()
end, {})
