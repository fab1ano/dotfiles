local is_nvim = vim.fn.has('nvim') == 1

if is_nvim then
  --- Configure neo-tree
  require("neo-tree").setup({
    enable_diagnostic = false,
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    filesystem = {
      hijack_netrw_behavior = "open_default",
      window = {
        mappings = {
          ["/"] = "fuzzy_sorter"
        },
      },
    },
    window = {
      width = 40,
    },
    default_component_configs = {
      indent = {
        indent_size = 1,
        padding = 1,
      },
    },
  })

  --- Configure no-neck-pain
  require("no-neck-pain").setup({
    debug = false,
    width = 180,
    autocmds = {
      enableOnVimEnter = true,
      enableOnTabEnter = true,
      skipEnteringNoNeckPainBuffer = true,
    },
    integrations = {
      NeoTree = {
        position = "left",
        reopen = true,
      },
    },
  })
end

--- Issues:
--- 1. font for icons
--- 2. background color after preview
--- 3. tabs of multiple files
