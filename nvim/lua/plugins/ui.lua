return  {
    -- Themes
    { -- Used by "LuaLine"
        'olivercederborg/poimandres.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('poimandres').setup {
                disable_background = true, -- disable background
            }
        end,
        init = function()
            -- vim.cmd("colorscheme poimandres")
        end
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function()
            local Color = require('github-theme.lib.color')

            local opts = {
                transparent = true,
                styles = {
                    comments = "italic",
                    functions = "bold"
                },
            }

            -- "Mint skyline" - Nick // @Creator Daniel Häll
            local typeclr = "#26867d";
            local varclr = "#add7ff";
            local constclr = "#5de4c7";
            local spec = {
                github_dark = {
                    syntax = {
                        -- bracket = "",
                        builtin0 = varclr,
                        builtin1 = typeclr,
                        builtin2 = constclr,
                        comment = "#7390aa",
                        -- conditional = "",
                        const = constclr,
                        -- field = "",
                        func = "#01f9c6",
                        -- ident = "",
                        keyword = "#557bad",
                        number = "#add7ff",
                        -- operator = "",
                        preproc = constclr,
                        regex = "#e2bec6",
                        -- statement = "",
                        string = "#91b4d5",
                        type = typeclr,
                        variable = varclr,
                    }
                }
            }


            require('github-theme').setup({
                options = opts,
                specs = spec,
            })
        end,
        init = function()
            vim.cmd("colorscheme github_dark")
        end
    },


}
