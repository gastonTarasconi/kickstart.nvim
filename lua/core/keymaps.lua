-- Set leader key to space
vim.g.mapleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Harpoon
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = 'Add file to harpoon' })
vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = 'Toggle harpoon ui' })
vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end,
  { desc = 'Navigate to harpoon 1 file' })
vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end,
  { desc = 'Navigate to harpoon 2 file' })
vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end,
  { desc = 'Navigate to harpoon 3 file' })
vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end,
  { desc = 'Navigate to harpoon 4 file' })
vim.keymap.set("n", "<leader>5", function() require("harpoon.ui").nav_file(5) end,
  { desc = 'Navigate to harpoon 5 file' })
vim.keymap.set("n", "<leader>6", function() require("harpoon.ui").nav_file(6) end,
  { desc = 'Navigate to harpoon 6 file' })
vim.keymap.set("n", "<leader>7", function() require("harpoon.ui").nav_file(7) end,
  { desc = 'Navigate to harpoon 7 file' })
vim.keymap.set("n", "<leader>8", function() require("harpoon.ui").nav_file(8) end,
  { desc = 'Navigate to harpoon 8 file' })
vim.keymap.set("n", "<leader>9", function() require("harpoon.ui").nav_file(9) end,
  { desc = 'Navigate to harpoon 9 file' })

-- Telescope
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})


local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


-- Git-blame
vim.keymap.set("n", "<leader>tgb", ":GitBlameToggle<CR>", { desc = '[T]oggle [G]it [B]lame' })

-- Nvim-dap
-- vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
-- vim.keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
-- vim.keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
-- vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
-- vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
-- vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
-- vim.keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
-- vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
-- vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
-- vim.keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
-- vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
-- vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
-- vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)


-- LSP
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { desc = 'Type [D]efinition' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

-- See `:help K` for why this keymap
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

-- Lesser used LSP functionality
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
vim.keymap.set('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = '[W]orkspace [L]ist Folders' })

-- Treesitter
vim.keymap.set('n', '<leader>c', function() require("treesitter-context").go_to_context() end, { silent = true, desc = 'Go to [C]ontext' })

