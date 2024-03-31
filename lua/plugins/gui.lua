return{
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
	    require("bufferline").setup{
	        options = {
	            mode = "buffers",
	            close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
	            left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
	            indicator ={
	                icon = '▎',
	                style = 'icon'
	            },
	            buffer_close_icon = '󰅖',
	            modified_icon = '●',
	            close_icon = '',
	            left_trunc_marker = "",
	            right_trunc_marker = "",
	            numbers = 'none',
	            max_name_length = 18,
	            max_prefix_length = 15, -- prefix used when a buffer is deduplicated
	            tab_size = 18,
	            diagnostics = "coc",
	            diagnostics_indicator = function(count, level, diagnostics_dict, context)
	                local icon = level:match("error") and " " or ""
	                return " " .. icon .. count
	            end,
	            enforce_regular_tabs = false,
	            offsets = {
	              {
	                filetype = "NvimTree",
	                text = "File Explorer",
	                highlight = "Directory",
	                text_align = "center"
	              }
	            },
	            custom_areas = {
	              right = function()
	                local result = {}
	                local seve = vim.diagnostic.severity
	                local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
	                local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
	                local info = #vim.diagnostic.get(0, {severity = seve.INFO})
	                local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

	                if error ~= 0 then
	                  table.insert(result, {text = "  " .. error, fg = "#EC5241"})
	                end

	                if warning ~= 0 then
	                  table.insert(result, {text = "  " .. warning, fg = "#EFB839"})
	                end

	                if hint ~= 0 then
	                  table.insert(result, {text = "  " .. hint, fg = "#A3BA5E"})
	                end

	                if info ~= 0 then
	                  table.insert(result, {text = "  " .. info, fg = "#7EA9A7"})
	                end
	                return result
	              end,
	            }
	        }
	    }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
	    require('lualine').setup {
	        options = {
	            icons_enabled = true,
	            theme = 'codedark',
	            component_separators = { left = '', right = ''},
	            section_separators = { left = '', right = ''},
	            disabled_filetypes = {
	                statusline = {},
	                winbar = {},
	            },
	            ignore_focus = {},
	            always_divide_middle = true,
	            globalstatus = false,
	            refresh = {
	                statusline = 1000,
	                tabline = 1000,
	                winbar = 1000,
	            }
	        },
	        sections = {
	            lualine_a = {'mode'},
	            lualine_b = {'branch', 'diff', 'diagnostics'},
	            lualine_c = {'filename'},
	            lualine_x = {'encoding', 'fileformat', 'filetype'},
	            lualine_y = {'progress'},
	            lualine_z = {'location'}
	        },
	        inactive_sections = {
	            lualine_a = {},
	            lualine_b = {},
	            lualine_c = {'filename'},
	            lualine_x = {'location'},
	            lualine_y = {},
	            lualine_z = {}
	        },
	            tabline = {},
	            winbar = {},
	            inactive_winbar = {},
	            extensions = {}
	    }
        end
    },
    {
	    "nvim-tree/nvim-tree.lua",
	    lazy = false,
	    config = function()
            --vim.g.loaded_netrw = 0
            --vim.g.loaded_netrwPlugin = 0
            vim.g.nvim_tree_auto_open = 1
	    	require("nvim-tree").setup{
            	 	git = {
            	 	    enable = true,
            	 	    ignore = false,
            	 	    show_on_dirs = true,
            	 	    timeout = 400,
            	 	},
	    	 	sort = {
	    	 	  sorter = "case_sensitive",
	    	 	},
            	    hijack_netrw = true,
            	    hijack_directories = {
            	      enable = false,
            	      auto_open = false,
            	    },
	    	 	view = {
	    	 	  width = 30,
	    	 	},
        		filesystem_watchers = {
        		    enable = false,
        		    debounce_delay = 50,
        		},
	    	 	renderer = {
	    	 	  group_empty = true,
	    	 	},
	    	 	filters = {
	    	 	  dotfiles = true,
	    	 	}
 	    	}
	    end
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup {
            override = {
                 zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh"
                 }
            };
            color_icons = true;
            default = true;
            strict = true;
            override_by_filename = {
                 [".gitignore"] = {
                   icon = "",
                   color = "#f1502f",
                   name = "Gitignore"
                 }
            };
            override_by_extension = {
                 ["log"] = {
                   icon = "",
                   color = "#81e043",
                   name = "Log"
                 }
            };
        }

        end
    }
}
