-- load nvchad mappings
require "nvchad.mappings"
local map = vim.keymap.set
-- ignore these buttons (conflict with wezterm)
map('n', '<A-o>', '<Nop>', { desc = "No operation" })
map('i', '<A-o>', '<Nop>', { desc = "No operation" })
map('v', '<A-o>', '<Nop>', { desc = "No operation" })
map('t', '<A-o>', '<Nop>', { desc = "No operation" })

map('v', 'y', '"+y', { desc = "Yank to system clipboard (visual mode)" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the top window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the bottom window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
map('n', 'K', vim.lsp.buf.hover, { desc = "Show hover documentation" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
map('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show signature help" })
map('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', '<space>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', 'gr', vim.lsp.buf.references, { desc = "Find references" })

map('n', '<leader>dt', function()
	local current_setting = vim.diagnostic.config().virtual_text
	if current_setting then
		vim.diagnostic.config({ virtual_text = false })
		print("LSP virtual text disabled")
	else
		vim.diagnostic.config({ virtual_text = true })
		print("LSP virtual text enabled")
	end
end, { desc = "Toggle LSP virtual text" })

map('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostic details" })
map('n', '<space>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })


-- Conform formatting
local conform = require("conform")
map('n', '<space>f', function()
    conform.format({
        async = true,
        lsp_fallback = true,
    })
end, { desc = "Format code with conform.nvim" })


-- CMP Mappings
local cmp = require('cmp')
local luasnip = require('luasnip')

_G.cmp_mappings = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
})

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files" })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = "Live grep" })
map('n', '<leader>fb', '<cmd>Telescope buffer <cr>', { desc = "Buffers" })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = "Help tags" })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = "Recent files" })

-- Harpoon
local harpoon = require("harpoon")

map("n", "<space>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
map("n", "<C-e>", function()
    local conf = require("telescope.config").values
    local harpoon_files = harpoon:list()
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end, { desc = "Open harpoon window" })

map("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

map("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
map("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })

-- Lazygit
map("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "Open LazyGit" })

-- Undotree
map("n", "<F5>", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- Oil
map('n', '-', "<cmd>Oil<cr>", { desc = "Open parent directory with Oil" })
