-- <leader> key
vim.g.mapleader = " ";

-- Navigation
vim.keymap.set("n", "<leader>nv", vim.cmd.Ex)

-- Delete into void instead of cpy buffer
vim.keymap.set("x", "<leader>p", "\"_dP");
vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("v", "<leader>d", "\"_d");

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y");
vim.keymap.set("v", "<leader>y", "\"+y");


-- ALE
vim.keymap.set('n', '<F2>', ':ALERename <CR>');
vim.keymap.set('n', 'K', ':ALEGoToDefinition -vsplit<CR>');
vim.keymap.set('n', 'R', ':ALEFindReferences -vsplit<CR>');


