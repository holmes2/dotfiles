vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.syntax = "on"
vim.wo.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamed"
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.g.netrw_liststyle = 3
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

CorpusDirectories = {
  ['~/Documents/Corpus'] = {
    autocommit = true,
    autoreference = 1,
    autotitle = 1,
    base = './',
    transform = 'local',
  },
}
vim.g.CorpusDirectories = CorpusDirectories

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local numbertogglegroup = augroup("numbertoggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true
  end,
  group = numbertogglegroup,
})

autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = false
  end,
  group = numbertogglegroup,
})

vim.cmd[[colorscheme tokyonight]]
vim.cmd("highlight ColorColumn ctermbg=yellow guibg=yellow")
vim.opt.colorcolumn = "100"
-- For ruby files, set indentation to 2 spaces
autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
-- For python files, set indentation to 4 spaces
autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

