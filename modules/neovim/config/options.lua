local o = vim.o

-- General settings
o.title = true
o.undofile = true

-- general split config
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Line numbers
o.number = true
o.relativenumber = true

-- Scrolling
o.scrolloff = 10

-- Indentation
o.smartindent = true
o.tabstop = 4       -- Number of spaces a <Tab> in the file counts for
o.softtabstop = 4   -- Number of spaces a <Tab> counts for while editing
o.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
o.expandtab = false -- Use tabs instead of spaces

-- Clipboard (empty = don't sync with system clipboard automatically)
o.clipboard = ""

-- Window appearance
o.winborder = 'rounded'
