local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	  'nvim-lua/plenary.nvim',
	  'nvim-telescope/telescope.nvim',
      'Mofiqul/vscode.nvim',
      {
          'nvim-treesitter/nvim-treesitter',
          build = ':TSUpdate',
      },
      'ThePrimeagen/harpoon',
      'mbbill/undotree',
      'tpope/vim-fugitive',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      {
          'VonHeikemen/lsp-zero.nvim',
          branch = 'v3.x',
      }
})
