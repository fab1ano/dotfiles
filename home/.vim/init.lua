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

  require('mason').setup()
  require('mason-lspconfig').setup({
    ensure_installed = { 'pyright', 'jdtls', 'clangd' },
  })

  --- Symbol outline
  require('aerial').setup({
    layout = { default_direction = 'right', min_width = 30 },
    attach_mode = 'global',
  })
  vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')

  --- Fuzzy picker
  local fzf = require('fzf-lua')
  fzf.setup({})
  vim.keymap.set('n', '<leader>ff', fzf.files,             { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', fzf.live_grep,         { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', fzf.buffers,           { desc = 'Buffers' })
  vim.keymap.set('n', '<leader>fs', fzf.lsp_workspace_symbols, { desc = 'Workspace symbols' })
  vim.keymap.set('n', '<leader>fd', fzf.lsp_document_symbols,  { desc = 'Document symbols' })
  vim.keymap.set('n', '<leader>fr', fzf.lsp_references,    { desc = 'References' })

  --- Diagnostics/references sidebar
  require('trouble').setup({})
  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>')
  vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<CR>')
  vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp_references toggle<CR>')

  --- Hex editor
  require 'hex'.setup()
end

--- Issues:
--- 1. font for icons
--- 2. background color after preview
--- 3. tabs of multiple files
