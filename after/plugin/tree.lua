local t = require("nvim-tree")

vim.keymap.set("n", "<leader>t", function ()
    t.toggle(true)
end)
