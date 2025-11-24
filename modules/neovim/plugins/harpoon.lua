local harpoon = require("harpoon")
harpoon:setup()

local map = vim.keymap.set

map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
map("n", "<leader>d", function() harpoon:list():remove() end, { desc = "Remove file from harpoon" })

map("n", "<S-tab>", function()
	local conf = require("telescope.config").values
	local file_paths = {}
	for _, item in ipairs(harpoon:list().items) do
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

-- Quick navigation to harpoon files
map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
