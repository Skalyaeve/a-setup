vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>W", ":wa<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":qa<CR>")
vim.keymap.set("n", "<leader>s", ":%s/")

vim.keymap.set("n", "<M-t>", ":tabnew<CR>")
vim.keymap.set("n", "<M-f>", "<C-w>T")
vim.keymap.set("n", "<M-w>", ":tabclose<CR>")
vim.keymap.set("n", "<M-1>", "1gt")
vim.keymap.set("n", "<M-2>", "2gt")
vim.keymap.set("n", "<M-3>", "3gt")
vim.keymap.set("n", "<M-4>", "4gt")
vim.keymap.set("n", "<M-5>", "5gt")
vim.keymap.set("n", "<M-6>", "6gt")
vim.keymap.set("n", "<M-7>", "7gt")
vim.keymap.set("n", "<M-8>", "8gt")
vim.keymap.set("n", "<M-9>", "9gt")
vim.keymap.set("n", "<M-a>", ":tabprev<CR>")
vim.keymap.set("n", "<M-A>", ":tabmove -1<CR>")
vim.keymap.set("n", "<M-e>", ":tabnext<CR>")
vim.keymap.set("n", "<M-E>", ":tabmove +1<CR>")

vim.keymap.set("n", "<M-h>", ":split<CR>")
vim.keymap.set("n", "<M-v>", ":vsplit<CR>")
vim.keymap.set("n", "<M-$>", ":term<CR>")
vim.keymap.set("n", "<M-z>", "<C-w>k")
vim.keymap.set("n", "<M-Z>", "<C-w>K")
vim.keymap.set("n", "<M-s>", "<C-w>j")
vim.keymap.set("n", "<M-S>", "<C-w>J")
vim.keymap.set("n", "<M-q>", "<C-w>h")
vim.keymap.set("n", "<M-Q>", "<C-w>H")
vim.keymap.set("n", "<M-d>", "<C-w>l")
vim.keymap.set("n", "<M-D>", "<C-w>L")

vim.keymap.set("n", "œ", ":NERDTreeToggle<CR>")
vim.keymap.set("n", "Œ", ":NERDTreeFocus<CR>")
vim.keymap.set("n", "<leader>œ", ":NERDTree ")
vim.keymap.set("n", "<leader>o", ":on<CR>")

vim.keymap.set("n", "<leader>1", ":e ~/.config/nvim/lua/binds.lua<CR>")
vim.keymap.set("n", "<leader>2", ":e ~/.config/nvim/colors/neon.lua<CR>")
vim.keymap.set("n", "<leader>3", ":e ~/.config/nvim<CR>")
vim.keymap.set("n", "<leader>4", ":e ~/.bash_aliases<CR>")
vim.keymap.set("n", "<leader>5", ":e ~/setup/terminal/bash<CR>")
vim.keymap.set("n", "<leader>6", ":e ~/.config/alacritty/alacritty.yml<CR>")
vim.keymap.set("n", "<leader>7", ":e ~/.config/i3/binds.conf<CR>")
vim.keymap.set("n", "<leader>8", ":e ~/.config/i3/config<CR><CR>")
vim.keymap.set("n", "<leader>9", ":e ~/setup/gui/jgmenu/set/main<CR>")
vim.keymap.set("n", "<leader>0", ":e ~/setup<CR>")
vim.keymap.set("n", "<leader>.", ":e ~/setup/utils/bin<CR>")
vim.keymap.set("n", "<leader>/", ":e ~/<CR>")
vim.keymap.set("n", "<leader>*", ":e ~/.local/share/git<CR>")
vim.keymap.set("n", "<leader>-", ":e#<CR>")
vim.keymap.set("n", "<leader>+", ":e ")

vim.keymap.set("n", "&", ":CopilotChatToggle<CR>")
vim.keymap.set("n", "&c", ":CopilotChatReset<CR>")
vim.keymap.set("n", "& ", ":CopilotChat ")
vim.keymap.set("v", "& ", ":CopilotChat ")
vim.keymap.set("v", "&r", ":CopilotChatReview<CR>")
vim.keymap.set("v", "&o", ":CopilotChatOptimize<CR>")
vim.keymap.set("v", "&d", ":CopilotChatDocs<CR>")
vim.keymap.set("v", "&e", ":CopilotChatExplain<CR>")
vim.keymap.set("n", "&f", ":CopilotChatFix<CR>")
vim.keymap.set("n", "&z", ":CopilotChatFixDiagnostic<CR>")
vim.keymap.set("n", "&t", ":CopilotChatTests<CR>")
vim.keymap.set("n", "&s", ":CopilotChatSave ")
vim.keymap.set("n", "&l", ":CopilotChatLoad ")
vim.keymap.set("n", "&g", ":CopilotChatCommit<CR>")
vim.keymap.set("n", "&*",  function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        require("CopilotChat").ask(input, {
            selection = require("CopilotChat.select").buffer
        })
    end
end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fv', builtin.vim_options, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})

vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("n", "<C-f>", ":Autoformat<CR>")
vim.keymap.set("n", "<leader>,", ":Inspect<CR>")
