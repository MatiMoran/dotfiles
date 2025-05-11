return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup {
                defaults = {
                    file_ignore_patterns = { ".git/", "node_modules/" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                }
            }

            telescope.load_extension("fzf")

            -- keymaps
            local keymaps = vim.keymap

            keymaps.set("n", "<leader>s", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)

            keymaps.set("n", "<C-p>", function()
                builtin.find_files({ hidden=true });
            end)
        end,
    }
}
