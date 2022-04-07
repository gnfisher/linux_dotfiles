return require('packer').startup(function(use)
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' }
    },
  })
  use({ 'nvim-telescope/telescope-ui-select.nvim' })
  use({ 'nvim-treesitter/nvim-treesitter' })
  use({ 'plasticboy/vim-markdown' })
  use({ 'tpope/vim-projectionist' })
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
  use({ 'mfussenegger/nvim-lint' })
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
  use({ 'metalelf0/jellybeans-nvim' })
  use({ 'morhetz/gruvbox' })
  use({ 'yasukotelin/shirotelin' })
  use({'folke/tokyonight.nvim'})
  use({ 'kyazdani42/nvim-web-devicons' })
  use({ 'wbthomason/packer.nvim', opt = true })
  use({ 'vim-test/vim-test'})
  use({ 'jeffkreeftmeijer/vim-dim' })
end)
