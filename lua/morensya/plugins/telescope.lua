return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  -- Fix for Neovim 0.11+: ft_to_lang was removed
  init = function()
    -- Add compatibility shim for ft_to_lang
    if not vim.treesitter.ft_to_lang then
      vim.treesitter.ft_to_lang = function(ft)
        return ft
      end
    end
  end,
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- Helper function to switch to existing tab or open in new tab
    local function smart_open(prompt_bufnr)
      local action_state = require("telescope.actions.state")
      local entry = action_state.get_selected_entry()
      local path = entry and entry.value or entry.filename

      if not path then
        actions.select_default(prompt_bufnr)
        return
      end

      -- Check if file is already open in any tab
      for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name == path then
            -- File is open in this tab, switch to it
            actions.close(prompt_bufnr)
            vim.api.nvim_set_current_tabpage(tabpage)
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end

      -- File not open in any tab, use default action (open in current window)
      actions.select_default(prompt_bufnr)
    end

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<CR>"] = smart_open,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
            ["<C-v>"] = actions.select_vertical,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-n>"] = actions.select_tab,
          },
          n = {
            ["<CR>"] = smart_open,
            ["<C-v>"] = actions.select_vertical,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-n>"] = actions.select_tab,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
