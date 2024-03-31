local keyMapper = require('utils.keyMapper').mapKey

return{
    {
        'prabirshrestha/vim-lsp'
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {"clangd", "pylsp", "html", "bashls", "svlangserver", "lua_ls"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.clangd.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.pylsp.setup({
               settings = {
                   pylsp = {
                       plugins = {
                           jedi_completion = {
                               include_params = true,
                           },
                           pycodestyle = {
                               enabled = true,
                               maxLineLength = 120
                           },
                           pyflakes = {
                               enabled = true
                           }
                       }
                   }
               }
            })
            lspconfig.html.setup({})
            lspconfig.bashls.setup({})

            keyMapper('K', vim.lsp.buf.hover)
            keyMapper('<leader>s', vim.lsp.buf.code_action)

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                  vim.lsp.buf.format { async = true }
                end, opts)
              end,
            })
        end
    },
    --{
        --'jose-elias-alvarez/null-ls.nvim',
        --config = function()
            --require("null-ls").setup({
                --debug = true,
                --sources = {
                    --require("null-ls").builtins.formatting.black.with({ extra_args = {"--line-length=120", "--target-version=py38"}}),
                    --require("null-ls").builtins.formatting.stylua,
                --},
            --})
        --end
    --},
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'dmitmel/cmp-vim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',

            'honza/vim-snippets',
            -- vsnip 
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',

            -- luasnip
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- ultisnips
            'SirVer/ultisnips',
            'quangnguyen30192/cmp-nvim-ultisnips',

            -- snippy
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy',
        },
        config = function()
             local cmp = require'cmp'
             cmp.setup({
               snippet = {
                 expand = function(args)
                   vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                   require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                   require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.fn.stdpath "config" .. "~/.local/share/nvim/lazy/vim-snippets/" }
                   require('snippy').expand_snippet(args.body) -- For `snippy` users.
                   vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                   vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                 end,
               },
               window = {
                 --completion = cmp.config.window.bordered(),
                 --documentation = cmp.config.window.bordered(),
               },
               --mapping = cmp.mapping.preset.insert({
                 ----['<C-b>'] = cmp.mapping.scroll_docs(-4),
                 ----['<C-f>'] = cmp.mapping.scroll_docs(4),
                 ----['<C-Space>'] = cmp.mapping.complete(),
                 ----['<C-e>'] = cmp.mapping.abort(),
                 --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
               --}),
               --sources = cmp.config.sources({
                 --{ name = 'nvim_lsp' },
                 --{ name = 'nvim_lua' },
                 --{ name = 'vim_lsp' },
                 --{ name = 'vsnip' }, -- For vsnip users.
                 --{ name = 'luasnip' }, -- For luasnip users.
                 --{ name = 'ultisnips' }, -- For ultisnips users.
                 --{ name = 'snippy' }, -- For snippy users.
               --}, {
                 --{ name = 'buffer' },
                 --{ name = 'path' },
               --})
             })

             -- Set configuration for specific filetype.
             cmp.setup.filetype('gitcommit', {
               sources = cmp.config.sources({
                 { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
               }, {
                 { name = 'buffer' },
               })
             })

             -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
             cmp.setup.cmdline({ '/', '?' }, {
               mapping = cmp.mapping.preset.cmdline(),
               sources = {
                 { name = 'buffer' }
               }
             })

             -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
             cmp.setup.cmdline(':', {
               mapping = cmp.mapping.preset.cmdline(),
               sources = cmp.config.sources({
                 { name = 'path' }
               }, {
                 { name = 'cmdline' }
               }),
               matching = { disallow_symbol_nonprefix_matching = false }
             })
        end
    },
    {
        'neoclide/coc.nvim',
        branch = 'release',
        dependencies = {
            'honza/vim-snippets'
        },
        config = function ()

            -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
            -- delays and poor user experience
            vim.opt.updatetime = 300

            -- Always show the signcolumn, otherwise it would shift the text each time
            -- diagnostics appeared/became resolved
            vim.opt.signcolumn = "yes"

            local keyset = vim.keymap.set
            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
            keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
            keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

            -- Use <c-j> to trigger snippets
            keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-space> to trigger completion
            keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
            keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
            keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

            -- GoTo code navigation
            keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
            keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
            keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
            keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


            -- Use K to show documentation in preview window
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


            -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })


            -- Symbol renaming
            keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


            -- Formatting selected code
            keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
            keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


            -- Setup formatexpr specified filetype(s)
            vim.api.nvim_create_autocmd("FileType", {
                group = "CocGroup",
                pattern = "typescript,json",
                command = "setl formatexpr=CocAction('formatSelected')",
                desc = "Setup formatexpr specified filetype(s)."
            })

            -- Update signature help on jump placeholder
            vim.api.nvim_create_autocmd("User", {
                group = "CocGroup",
                pattern = "CocJumpPlaceholder",
                command = "call CocActionAsync('showSignatureHelp')",
                desc = "Update signature help on jump placeholder"
            })

            -- Apply codeAction to the selected region
            -- Example: `<leader>aap` for current paragraph
            local opts = {silent = true, nowait = true}
            keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
            keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

            -- Remap keys for apply code actions at the cursor position.
            keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
            --keyset("n", "<leader>ac", vim.lsp.buf.code_action, opts)
            -- Remap keys for apply source code actions for current file.
            keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
            -- Apply the most preferred quickfix action on the current line.
            keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

            -- Remap keys for apply refactor code actions.
            keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
            keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
            keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

            -- Run the Code Lens actions on the current line
            keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


            -- Map function and class text objects
            -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
            keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
            keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
            keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
            keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
            keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
            keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
            keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
            keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


            -- Remap <C-f> and <C-b> to scroll float windows/popups
            ---@diagnostic disable-next-line: redefined-local
            local opts = {silent = true, nowait = true, expr = true}
            keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
            keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
            keyset("i", "<C-f>",
                   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
            keyset("i", "<C-b>",
                   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
            keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
            keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


            -- Use CTRL-S for selections ranges
            -- Requires 'textDocument/selectionRange' support of language server
            keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
            keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


            -- Add `:Format` command to format current buffer
            vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

            -- " Add `:Fold` command to fold current buffer
            vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

            -- Add `:OR` command for organize imports of the current buffer
            vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

            -- Add (Neo)Vim's native statusline support
            -- NOTE: Please see `:h coc-status` for integrations with external plugins that
            -- provide custom statusline: lightline.vim, vim-airline
            vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

            -- Mappings for CoCList
            -- code actions and coc stuff
            ---@diagnostic disable-next-line: redefined-local
            local opts = {silent = true, nowait = true}
            -- Show all diagnostics
            keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
            -- Manage extensions
            keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
            -- Show commands
            keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
            -- Find symbol of current document
            keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
            -- Search workspace symbols
            keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
            -- Do default action for next item
            keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
            -- Do default action for previous item
            keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
            -- Resume latest coc list
            keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

        end
    },

}
