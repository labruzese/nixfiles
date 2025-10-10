local harpoon = require("harpoon")

harpoon:setup()

-- Mappings
local map = vim.keymap.set

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

map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

map("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
map("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
