-- Make .h a C type file

-- Group Creation
vim.api.nvim_create_augroup('C', { clear = true });


-- Behaviour
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
	desc = "Make .h into a C type file",
	group = 'C',
	pattern = {'*.h'},
	callback = function()
		local buf = vim.api.nvim_get_current_buf();
        vim.api.nvim_buf_set_option(buf, "filetype", "c");
	end,
});
