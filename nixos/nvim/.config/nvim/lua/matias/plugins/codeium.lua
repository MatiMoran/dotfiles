return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 
            "hrsh7th/nvim-cmp",

            -- Uncomment this code in case that we do not use lsp-zero
            -- config = function()
            --     require("cmp").setup({
            --         sources = {
            --             { name = "codeium" }
            --         }
            --     })
            -- end
        }
    },
    config = function()
        require("codeium").setup({})
    end
}
