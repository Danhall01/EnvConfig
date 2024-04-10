return {
    -- ALE: lsp + Linting / Fixing
    {
        "dense-analysis/ale",
        lazy = false,
        priority = 100,
        config = function()
            local g = vim.g;

            g.ale_disable_lsp = "auto"; -- Keep "auto" when using lsp-config, else 1


            vim.o.mouse = a;
            vim.o.mousemodel = popup_setpos;

            g.ale_lint_on_text_changed = "normal"; -- "always"
            g.ale_lint_on_insert_leave = 1;
            g.ale_lint_on_enter = 1;
            g.ale_lint_on_save = 1;

            g.ale_fix_on_save = 1;
            g.ale_warn_about_trailing_whitespace = 0;
            g.ale_warn_about_trailing_blank_lines = 0;


            g.ale_set_highlights = 1;

            g.ale_echo_msg_error_str = "-";
            g.ale_echo_msg_warning_str = "W";
            g.ale_echo_msg_format = "[%severity%]\t%s (%linter%)";

            g.ale_lsp_show_message_severity = "information";
            g.ale_lsp_suggestions = 1;

            g.ale_use_neovim_diagnostics_api = 1;

            g.ale_set_baloons = 1;
            g.ale_hover_to_preview = 1;

            g.ale_fixers = {
                ["c"] = {"clangtidy", "clang-format", "remove_trailing_lines", "trim_whitespace"},
                ["cpp"] = {"clangtidy", "clang-format", "remove_trailing_lines", "trim_whitespace"},
            };

            g.ale_linters = {
                ["c"] = {"clang", "cspell", "clangd", "clangcheck", "clangtidy"},
                ["cpp"] = {"cc", "cspell", "clangd", "clangcheck", "clangtidy", "cppcheck"},
                ["*"] = {"all"}
            };

            g.ale_c_parse_makefile = 1;

            -- Set correct header types
            g.ale_cpp_cc_header_exts = {"hpp"};
            g.ale_c_cc_header_exts = {'c'};

            g.ale_c_clangformat_use_local_file = 1;
            g.ale_cc_clangformat_use_local_file = 1;

            g.ale_c_clangtidy_checks = {};
            g.ale_cc_clangtidy_checks = {};

            local opts = "-std=c2x -Wall -Wextra -Wpedantic";
            g.ale_c_cc_options = opts;
        end,
        keys = {}
    },
    -- LSP-Config: LSP
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        priority = 100,
        dependencies = {
            "ms-jpq/coq_nvim"
        },
        config = function()
        end,
        keys = {
            { "<C-j>", function() vim.diagnostic.goto_next(); end, mode='n', desc = "Jump to next error" },
            { "<C-k>", function() vim.diagnostic.goto_prev(); end, mode='n', desc = "Jump to previous error" },
            { "<C-w>", function() vim.cmd("ClangdSwitchSourceHeader"); end, mode='n', desc="Swap between .h and .c files"},

            { "D", function() vim.lsp.buf.definition(); end, mode='n', desc="Go to definition" },
            { "<leader>d", function() vim.lsp.buf.definition(); end, mode='n', desc="Go to declaration" },
            { "T", function() vim.lsp.buf.type_definition(); end, mode='n', desc="Go to type definition" },
            { "I", function() vim.lsp.buf.implementation(); end, mode='n', desc="Go to implementation" },
            { "F", function() vim.lsp.buf.references(); end, mode='n', desc="Find all references" },
            { "K", function() vim.lsp.buf.hover(); end, mode='n', desc="Print information of hovered element" },

            { "<F2>", function() vim.lsp.buf.rename(); end, mode='n', desc="Rename hovered element" },
            { "<leader>F", function() vim.lsp.buf.code_action(); end, mode='n', desc="Attempt to fix problem under hover" },
        },
        init = function()
            local lspconfig = require("lspconfig");
            local coq = require("coq")
            -- C and Cpp
            lspconfig.clangd.setup{coq.lsp_ensure_capabilities()};
            -- Lua
            lspconfig.lua_ls.setup{coq.lsp_ensure_capabilities(
                {on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = true,
                        library = {
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                    })
                end,
                settings = {
                    Lua = {}
                }
            })};
            -- Cmake
            lspconfig.cmake.setup{coq.lsp_ensure_capabilities()};
            -- Python
            lspconfig.pylsp.setup{coq.lsp_ensure_capabilities()};
            -- JavaScript
            lspconfig.eslint.setup{coq.lsp_ensure_capabilities()};
        end
    },
    -- Auto-Completion
    {
        "ms-jpq/coq_nvim",
        branch = "coq",
        lazy = false,
        priority = 200, -- Has to load before lspconfig
        config = function()
            -- Auto enable COQ on run
            -- vim.cmd("COQnow");
        end,
        keys = {},
        init = function ()
            vim.g.coq_settings = {
                auto_start = true,
            }
        end,
        build = function()
            vim.cmd("COQdep");
        end,
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        priority = 100,
        config = function ()
        end,
        keys = {},
        init = function()
            require'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all"
                ensure_installed = { "c", "lua", "vim", "vimdoc" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    -- Experimental
                    enable = false,
                },
            }
        end,
        build = function()
            vim.cmd("TSUpdate");
        end,
    },

}
