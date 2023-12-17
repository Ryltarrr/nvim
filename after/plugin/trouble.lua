local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
})

vim.keymap.set("n", "<leader>xj<cr>", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
vim.keymap.set("n", "<leader>xk<cr>", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)
