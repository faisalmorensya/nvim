return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Allow resizing nvim-tree with mouse
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.opt_local.winfixwidth = false
        vim.opt_local.winfixheight = false
      end,
    })

    nvimtree.setup({
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = "25%",
        relativenumber = true,
      },
      -- custom keymaps for file operations
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Helper function to switch to existing tab or open in new tab
        local function smart_open()
          local node = api.tree.get_node_under_cursor()
          if not node then
            return
          end

          local path = node.absolute_path

          -- Check if file is already open in any tab
          for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
              local buf = vim.api.nvim_win_get_buf(win)
              local buf_name = vim.api.nvim_buf_get_name(buf)
              if buf_name == path then
                -- File is open in this tab, switch to it
                vim.api.nvim_set_current_tabpage(tabpage)
                vim.api.nvim_set_current_win(win)
                return
              end
            end
          end

          -- File not open in any tab, open in new tab
          api.node.open.tab()
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<CR>", smart_open, opts("Smart open: switch if open, else new tab"))
        vim.keymap.set("n", "m", api.fs.rename, opts("Move/Rename"))
      end,
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = true,
          },
          resize_window = false,
        },
      },
      tab = {
        sync = {
          open = true, -- sync nvim-tree across tabs
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
    keymap.set("n", "<leader>et", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" }) -- focus file explorer

    -- create new file
    keymap.set("n", "<leader>en", function()
      local filename = vim.fn.input("New file name: ", "", "file")
      if filename ~= "" then
        vim.cmd("e " .. filename)
      end
    end, { desc = "Create new file" })
  end,
}
