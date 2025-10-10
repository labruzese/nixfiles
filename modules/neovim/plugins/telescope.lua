local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
            },
        },
        file_ignore_patterns = {
            "node_modules",
            ".git",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

telescope.load_extension("fzf")

-- Mappings
local map = vim.keymap.set
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files" })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = "Live grep" })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = "Buffers" })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = "Help tags" })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = "Recent files" })
