return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup { 'max-perf' }

    -- Use git ls-files for file search (instant on Lustre, vs 18s with fd)
    vim.keymap.set('n', '<leader>sf', fzf.git_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader>sc', fzf.commands, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>sn', function() fzf.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })

    -- LSP keymaps (set on attach)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('fzf-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf
        vim.keymap.set('n', 'grr', fzf.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', fzf.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
        vim.keymap.set('n', 'grd', fzf.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
        vim.keymap.set('n', 'gO', fzf.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
        vim.keymap.set('n', 'gW', fzf.lsp_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
        vim.keymap.set('n', '<leader>ss', fzf.lsp_live_workspace_symbols, { buffer = buf, desc = '[S]earch [S]ymbols (workspace)' })
        vim.keymap.set('n', '<leader>sS', fzf.lsp_document_symbols, { buffer = buf, desc = '[S]earch [S]ymbols (current file)' })
        vim.keymap.set('n', 'grt', fzf.lsp_typedefs, { buffer = buf, desc = '[G]oto [T]ype Definition' })
      end,
    })
  end,
}
