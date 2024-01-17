vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected row up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- deletes whitespaces after string (is that correct?)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- goes to top or bottom of the current file
vim.keymap.set("n", "<C-g>", "<C-d>zz")
vim.keymap.set("n", "<C-t>", "<C-u>zz")

-- jumping forward/backward in your last story finder
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste (need to figure how exactly)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- combo copy + motion / copy from cursor till end
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- combo delete + motion
vim.keymap.set({"n", "v"}, "<leader>p", [["_d]])

-- exits insert mode by ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- need to figure this out, how to use sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

-- remaping Q for nothing ? purpose ?
vim.keymap.set("n", "Q", "<nop>")
-- something with lsp, its not working yet
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- this shit append to current selected word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- this shit i dunno yet
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- this goes to my init.lua file
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/ftl/init.lua<CR>");

-- this makes fun animation
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
