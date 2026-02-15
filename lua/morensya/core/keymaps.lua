vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- Smart tab: switch to existing tab if buffer is already open, otherwise create new tab
keymap.set("n", "<leader>tf", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_tab = vim.api.nvim_get_current_tabpage()

  -- Check if buffer is open in another tab
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    if tabpage ~= current_tab then
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
        if vim.api.nvim_win_get_buf(win) == current_buf then
          -- Buffer found in another tab, switch to it
          vim.api.nvim_set_current_tabpage(tabpage)
          return
        end
      end
    end
  end

  -- Buffer not in any other tab, create new tab
  vim.cmd("tab split")
end, { desc = "Smart tab: switch if open, else new tab" })

-- select all and copy
keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>Y", "ggVG\"+y", { desc = "Select all and copy" })

-- macOS-style keymaps (Option = word, Cmd = line/file boundaries)
-- Option + Arrow = move by word
for _, mode in ipairs({ "n", "i", "v" }) do
  keymap.set(mode, "<A-Left>", mode == "i" and "<C-o>b" or "b", { desc = "Word left" })
  keymap.set(mode, "<A-Right>", mode == "i" and "<C-o>w" or "w", { desc = "Word right" })
  keymap.set(mode, "<A-Up>", mode == "i" and "<C-o>{" or "{", { desc = "Paragraph up" })
  keymap.set(mode, "<A-Down>", mode == "i" and "<C-o>}" or "}", { desc = "Paragraph down" })
end

-- Cmd + Arrow = start/end of line or file
for _, mode in ipairs({ "n", "i", "v" }) do
  keymap.set(mode, "<D-Left>", mode == "i" and "<C-o>0" or "0", { desc = "Line start" })
  keymap.set(mode, "<D-Right>", mode == "i" and "<C-o>$" or "$", { desc = "Line end" })
  keymap.set(mode, "<D-Up>", mode == "i" and "<C-o>gg" or "gg", { desc = "File start" })
  keymap.set(mode, "<D-Down>", mode == "i" and "<C-o>G" or "G", { desc = "File end" })
end

-- indent/unindent with Tab/Shift+Tab in visual mode
keymap.set("v", "<Tab>", ">gv", { desc = "Indent right" })
keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left" })
