
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


plugins = {
  -- General plugins
  'wincent/corpus', -- For Note Taking
  'tpope/vim-commentary', -- For Commenting
  'tpope/vim-surround', -- For Sorrounding brackets
  'tpope/vim-fugitive', -- For Git Activities
  'prichrd/netrw.nvim', -- Netrw
  'lewis6991/gitsigns.nvim', -- git signs like git lens
  { 'github/copilot.vim',
    init= function()
      require("copilot").setup()
      vim.g.copilot_filetypes = {yaml = true, gitcommit=true }
        vim.api.nvim_set_keymap('i', '<C-f>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
    end
  },

  {
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" },
      { 'github/copilot.vim' }

      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
        -- Your COQ settings here
        keymap = {
          recommended = false,
          jump_to_mark = '',
          pre_select = true,
        },
        auto_start = false, -- if you want to start COQ at startup
        display = {
          pum = {
            fast_close = false
          }
        }
      }
      require'coq'
      require("coq_3p") {
        { src = "copilot", short_name = "COP", accept_key = "<c-f>" }
      }
    end,
    config = function()
      -- Your LSP settings here
      local lspconfig = require('lspconfig')

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { 'solargraph', 'ts_ls' }
      local coq = require "coq"
      for _, lsp in ipairs(servers) do
        if (lsp == 'tsserver')
        then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            cmd = { "/Users/priyanklalitkantkapadia/.nvm/versions/node/v12.19.0/bin/typescript-language-server", "--stdio" }
          }
        else
          lspconfig[lsp].setup(coq.lsp_ensure_capabilities{
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities
          })
        end
      end
    end,
  },
  'ms-jpq/coq.thirdparty', -- lua & third party sources

  -- Copilot
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    opts = { debug = true },
  },
    -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
    -- Airline
  'nvim-tree/nvim-web-devicons',
  { 'nvim-lualine/lualine.nvim', init = function() require('lualine').setup() end },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter',
  config= function() vim.cmd('TSUpdate') end,
  init=function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "lua", "ruby" },
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "ruby" },
      }
    }
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldlevel = 99
  end},
 --Image clip support
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    }
  },
  -- Telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  {
    'nvim-telescope/telescope-ui-select.nvim'
  },
  -- Lspsaga
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    }
  },
}


require("lazy").setup(plugins, opts)
require("tokyonight").setup({
  -- use the night style
  style = "night",
  -- disable italic for functions
  styles = {
    functions = {}
  },
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end
})
