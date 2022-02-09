return require('packer').startup(function(use)
  use({ 'rktjmp/lush.nvim' })
  use({ 'metalelf0/jellybeans-nvim' })
  use({ 'overcache/NeoSolarized' })
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
  })
  use({ 'nvim-telescope/telescope-ui-select.nvim' })
  use({ 'nvim-treesitter/nvim-treesitter' })
  use({ 'plasticboy/vim-markdown' })
  -- LSP/Lint
  use({ 'prettier/vim-prettier' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'mfussenegger/nvim-lint' })
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-nvim-lua' },
    },
  })
  use({ 'rafamadriz/friendly-snippets' })
  use({ 'scalameta/nvim-metals' })
  use({ 'mfussenegger/nvim-jdtls' })
  use({ 'mfussenegger/nvim-dap' })
  -- Dispatch
  use({ 'tpope/vim-dispatch' })
  -- Git(Hub)
  use({ 'tpope/vim-fugitive' })
  use({ 'tpope/vim-rhubarb' })
  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  })
  -- Unix
  use({ 'tpope/vim-vinegar' })
  use({ 'tpope/vim-eunuch' })
  -- Syntax helpers
  use({ 'sheerun/vim-polyglot' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-endwise' })
  use({ 'kana/vim-textobj-user' })
  use({ 'nelstrom/vim-textobj-rubyblock' })
  use({ 'tpope/vim-commentary' })
  -- Colors
  use({ 'morhetz/gruvbox' })
  use({ 'kyazdani42/nvim-web-devicons' })
  use({ 'wbthomason/packer.nvim', opt = true })
  -- org mode
  use({
    "nvim-neorg/neorg",
    tag = "latest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope"
    }
})
end)
