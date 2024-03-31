local mapKey = require("utils.keyMapper").mapKey
local map = vim.api.nvim_set_keymap
local options = { noremap = true }

-- function
map("n", "<F6>", ":.,$s/", options)
map("n", "<F9>", ":noh<Enter>", options)
map("n", "<F11>", ":%!xxd", options)

-- explore
map("c", "E<Enter>", "Explore<Enter>", options)

-- vim-easy-align
map("v", "<Enter>", "<Plug>(EasyAlign)", options)
map("n", "ga", "<Plug>(EasyAlign)", options)

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", options)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", options)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", options)
map("n", "<leader>fr", "<cmd>Telescope git_files<cr>", options)

-- nvim-tree
mapKey('<F2>', ':NvimTreeToggle<cr>')


-- bufferline
mapKey('<leader>.',  ':BufferLineCycleNext<CR>')
mapKey('<leader>,',  ':BufferLineCyclePrev<CR>')
mapKey('<leader>>',  ':BufferLineMoveNext<CR>')
mapKey('<leader><',  ':BufferLineMovePrev<CR>')
mapKey('<leader>1',  '<Cmd>BufferLineGoToBuffer 1<CR>')
mapKey('<leader>2',  '<Cmd>BufferLineGoToBuffer 2<CR>')
mapKey('<leader>3',  '<Cmd>BufferLineGoToBuffer 3<CR>')
mapKey('<leader>4',  '<Cmd>BufferLineGoToBuffer 4<CR>')
mapKey('<leader>5',  '<Cmd>BufferLineGoToBuffer 5<CR>')
mapKey('<leader>6',  '<Cmd>BufferLineGoToBuffer 6<CR>')
mapKey('<leader>7',  '<Cmd>BufferLineGoToBuffer 7<CR>')
mapKey('<leader>8',  '<Cmd>BufferLineGoToBuffer 8<CR>')
mapKey('<leader>9',  '<Cmd>BufferLineGoToBuffer 9<CR>')
mapKey('<leader>$',  '<Cmd>BufferLineGoToBuffer -1<CR>')

-- toggleterm
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], options)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], options)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], options)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], options)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], options)
  --vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- lazygit 
map("n", "<leader>gg", ":LazyGit<CR>", options)

-- Tagbar 
map("n", "<F12>", ":TagbarToggle<CR>", options)

-- blamer
map("n", "<F7>", ":BlamerToggle<CR>", options)

-- data-viewer
map("c", "csv<CR>", ":DataViewer<CR>", options)
