-- file type
vim.cmd[[au BufNewFile,BufRead *.v   set filetype=verilog]]
vim.cmd[[au BufNewFile,BufRead *.sv  set filetype=systemverilog]]
vim.cmd[[au BufNewFile,BufRead *.sv  so ~/.vim/syntax/verilog_systemverilog.vim]]
vim.cmd[[au BufNewFile,BufRead *.c   set filetype=c]]
vim.cmd[[au BufNewFile,BufRead *.rc  set filetype=bash]]
vim.cmd[[au BufNewFile,BufRead *.top set filetype=bash]]

-- coc 
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.coc_global_extensions = {"coc-pyright","coc-actions", 'https://github.com/andys8/vscode-jest-snippets'}
--vim.g.pymode_lint_ignore = "E501"
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
