vim.opt_local.spell = true
vim.opt_local.spelllang = "es"

vim.opt_local.wrap = true

-- 'z=' to correct word
-- 'zg' to add word to dict
-- '[s' next mispell word
-- ']s' prev mispell word
--

vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

if vim.fn.exists(":Goyo") == 2 then
  vim.cmd("Goyo")
end

