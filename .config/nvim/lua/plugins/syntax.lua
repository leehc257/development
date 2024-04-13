--vim.opt.background=dark

return{
    {
	    'Mofiqul/vscode.nvim',
	    priority = 1000,
	    config = function()
            local c = require('vscode.colors').get_colors()
            require('vscode').setup({
                transparent = true,
                italic_comments = true,
                disable_nvimtree_bg = true,
                color_overrides = {
                    vscLineNumber = '#FFFFFF',
                },

                group_overrides = {
                    Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
                }
            })
	    	vim.cmd([[colorscheme vscode]])
	    end,
    },
    {
	    "nvim-treesitter/nvim-treesitter",
	        build = ":TSUpdate",
	        config = function ()
	          local configs = require("nvim-treesitter.configs")

	          configs.setup({
	    	    ensure_installed = {"python" ,"c", "cpp", "lua", "make", "verilog"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	    	    sync_install = true,
	    	    auto_install = true,
	    	    highlight = {
	    	        enable = true,              -- false will disable the whole extension
	    	        disable = { "netrw", "bash",  "vim", "lua", "systemverilog" },  -- list of language that will be disabled
	    	        additional_vim_regex_highlighting = false,
	    	    },
	    	    rainbow = {
	    	    enable = true,
	    	    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	    	    max_file_lines = nil, -- Do not enable for files with more than n lines, int
	    	  },
	            })
	        end
    },
    {
        'p00f/nvim-ts-rainbow'
    }

}
