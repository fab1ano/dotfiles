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

  --- LSP
  require'lspconfig'.clangd.setup{
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    root_dir = require'lspconfig'.util.root_pattern(
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.git'
    ),
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
  })

  vim.lsp.enable('jdtls')
  vim.lsp.enable('pyright')

  --- Hex editor
  require 'hex'.setup()
end

--- Issues:
--- 1. font for icons
--- 2. background color after preview
--- 3. tabs of multiple files
