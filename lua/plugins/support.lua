return{
    {
        'chrisbra/csv.vim'
    },
    {
        'vidocqh/data-viewer.nvim',
        opts = {},
        dependencies = {
          "nvim-lua/plenary.nvim",
          "kkharji/sqlite.lua", -- Optional, sqlite support
        },
        config = function()
            require("data-viewer").setup{
              autoDisplayWhenOpenFile = false,
              maxLineEachTable = 100,
              columnColorEnable = false,
              columnColorRoulette = { -- Highlight groups
                "DataViewerColumn0",
                "DataViewerColumn1",
                "DataViewerColumn2",
              },
              view = {
                float = true, -- False will open in current window
                width = 0.8, -- Less than 1 means ratio to screen width, valid when float = true
                height = 0.8, -- Less than 1 means ratio to screen height, valid when float = true
                zindex = 50, -- Valid when float = true
              },
              keymap = {
                quit = "q",
                next_table = "<C-l>",
                prev_table = "<C-h>",
              },
            }
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function()
            local plugin = "notify plugin"
            function OnSave()
                vim.notify("File Saved", "info", {
                    title = plugin,
                    timeout = 2000,
                })
            end
            function NotifyOnReadOnlySave()
                local readonly = vim.fn.eval("&readonly") == 1
                if readonly then
                    vim.notify("ReadOnly File Saved", "warn", {
                        title = plugin,
                        timeout = 2000
                    })
                end
            end

            vim.notify = require("notify")
            require("notify").setup({
              -- Animation style (see below for details)
              stages = "fade_in_slide_out",

              -- Function called when a new window is opened, use for changing win settings/config
              on_open = nil,

              -- Function called when a window is closed
              on_close = nil,

              -- Render function for notifications. See notify-render()
              render = "default",

              -- Default timeout for notifications
              timeout = 5000,

              -- For stages that change opacity this is treated as the highlight behind the window
              -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
              background_colour = "#000000",

              -- Minimum width for notification windows
              minimum_width = 30,

              -- Icons for the different levels
              icons = {
                ERROR = "",
                WARN = "",
                INFO = "",
                DEBUG = "",
                TRACE = "✎",
              },
            })
            vim.cmd([[
                augroup AutoSaveNotify
                    autocmd!
                    autocmd BufWritePost * lua OnSave()
                augroup END
            ]])
            vim.cmd([[
                augroup NotifyOnReadOnlySave
                    autocmd!
                    autocmd BufWritePre * lua NotifyOnReadOnlySave()
                augroup END
            ]])
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            size = 10,
            direction = "horizontal",
            open_mapping = [[<leader>t]],
            shade_filetypes = {"none","bash"},
            shade_terminals = true,
            shading_factor = '1',
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            shell = vim.o.shell,
            float_opts = {
              border = 'curved',
              winblend = 0,
              highlights = {
                  border = 'Normal',
                  background = 'Normal',
                },
            },
        }
    },
    {
        'mhinz/vim-startify',
        config = function()
            vim.g.startify_custom_header = {
                        [[███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗]],
                        [[████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║]],
                        [[██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║]],
                        [[██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║]],
                        [[██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║]],
                        [[╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝]],
                        [[]],
                        [[██████╗░███████╗███████╗██╗░██████╗  ████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗░█████╗░██╗░░░░░]],
                        [[╚════██╗██╔════╝╚════██║╚█║██╔════╝  ╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗██║░░░░░]],
                        [[░░███╔═╝██████╗░░░░░██╔╝░╚╝╚█████╗░  ░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║███████║██║░░░░░]],
                        [[██╔══╝░░╚════██╗░░░██╔╝░░░░░╚═══██╗  ░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██╔══██║██║░░░░░]],
                        [[███████╗██████╔╝░░██╔╝░░░░░██████╔╝  ░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██║░░██║███████╗]],
                        [[╚══════╝╚═════╝░░░╚═╝░░░░░░╚═════╝░  ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚══════╝]]}
            vim.g.startify_lists = {
                                        { type= 'files',     header= {'   Files'}            },
                                        { type= 'dir',       header= {'   Curr dir'}   },
                                        { type= 'sessions',  header= {'   Sessions'}       },
                                        { type= 'bookmarks', header= {'   Bookmarks'}      } }
            vim.g.startify_bookmarks = { {vimrc= '~/.vimrc'}                    ,
                                         {init = '~/.config/nvim/init.vim'}         ,
                                         {rc   = '~/.zshrc'}                          ,
                                         {py   = '~/01.project/01.python/main.py'}    ,
                                         {sv   = '~/01.project/02.verilog/main.sv'}   ,
                                         {cpp  = '~/01.project/03.cpp/main.cpp'}    }

        end
    },
}
