-- Load my custom settings
require('alberth.settings')

-- Run LazyVim package manager
require('config.lazy')

-- Specify parameters for packages
require('lazy').setup({{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}})

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'nerdy')

-- Define whether I use a nerdfont or not
vim.g.have_nerd_font = true

-- Make showing line numbers the default
vim.opt.number = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Set color scheme
--vim.cmd.colorscheme('catppuccin-macchiato')
vim.opt.termguicolors = true
local pywal = require('pywal')
pywal.setup()

-- NeoVide specific items
if vim.g.neovide then
	vim.g.neovide_cursor_vfx_mode = "railgun"
end


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
