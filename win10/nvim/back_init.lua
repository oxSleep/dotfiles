-- Keybinds
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

vim.keymap.set('n', '<leader>p' , '<C-^>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Options
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- Options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.have_nerdfont = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.clipboard='unnamedplus'
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.pumheight = 12
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 11 
vim.opt.isfname:append('@-@')
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.winborder = 'rounded'
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = '#ifdef,#endif'

-- Bootstrap mini.deps
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Telescope
add({
    source = 'nvim-telescope/telescope.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
})
add({
    source = 'nvim-telescope/telescope-fzf-native.nvim',
    hooks = { post_install = function() vim.cmd('make') end },
})

later(function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
    })

    pcall(telescope.load_extension, 'fzf')

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = 'none' })

    vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>fF', builtin.find_files, { desc = 'Find All Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find by Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find Recent Files' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find Word under cursor' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find Commands' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
end)

-- Treesitter
add('nvim-treesitter/nvim-treesitter')
later(function()
    require('nvim-treesitter.configs').setup({
        auto_install = false,
        highlight = {
            enable = true,
        },
    })
end)

-- Blink completion
add({
    source = 'saghen/blink.cmp',
    depends = { 'rafamadriz/friendly-snippets' },
    checkout = "v1.3.1",

})
now(function()
    require('blink.cmp').setup({
        completion = { menu = { auto_show = false} },
        keymap = {
            preset = 'none',
            ['<Tab>']   = {
                function(cmp)
                    if cmp.snippet_active() then return cmp.accept()
                    else return cmp.select_next() end
                end,
                'snippet_forward',
                'fallback'
            },     
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<C-e>']    = { 'hide', 'fallback'},
            ['<CR>']    = { 'select_and_accept', 'fallback'},
            ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
        },
        cmdline = {
            enabled = false,
        },
        sources = {
            default = { 'buffer', 'snippets', 'path' }
        },
    })
end)

-- Colorscheme
add('slugbyte/lackluster.nvim')
now(function()
    local lackluster = require('lackluster')
    local color = lackluster.color
    lackluster.setup({
        tweak_syntax = {
            string = 'default',
            string_escape = 'default',
            comment = color.green,
            type = color.blue,
            keyword = color.orange,
            keyword_return = color.orange,
            keyword_exception = 'default',
        },
        tweak_background = {
            normal = 'none',
            menu   = 'none',
            popup  = 'none'
        }
    })
    vim.cmd.colorscheme('lackluster-hack')
    vim.api.nvim_set_hl(0, 'Normal', { bg = nil, ctermbg = nil })
end)

-- Oil
add({
    source = 'stevearc/oil.nvim',
    depends = { 'echasnovski/mini.icons' },
})
now(function()
    require('mini.icons').setup()
    require('oil').setup()
    local function toggle_oil_alternative()
        if vim.bo.filetype == 'oil' then
            -- Alternative approach: use Oil's own close function
            require('oil').close()
        else
            vim.cmd('Oil')
        end
    end
    vim.keymap.set('n', '<F2>', toggle_oil_alternative)
end)

-- Lsp
vim.lsp.config.clangd = {
    cmd = {
        'D:\\Scoop\\apps\\clangd\\current\\bin\\clangd.exe',
        '--background-index',
        '--enable-config',
    },
    root_dir = vim.fn.getcwd(),
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
}
vim.lsp.enable({'clangd'})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
                buffer = ev.buf,
                desc = 'LSP: Code Action',
            })
        end
    end,
})

vim.diagnostic.config({
    virtual_text = false,
    float = false,  -- This disables floating diagnostic windows
    signs = false,  -- This removes the error signs in the gutter
})

-- Switch source/header function for C/C++
-- This remains exactly the same - LSP functionality is independent of plugin manager
local function switch_source_header()
    local params = { uri = vim.uri_from_bufnr(0) }
    vim.lsp.buf_request(0, 'textDocument/switchSourceHeader', params, function(err, result)
        if err then
            vim.notify('Error finding alternate file: ' .. err.message, vim.log.levels.ERROR)
            return
        end
        if not result then
            vim.notify('No alternate file found', vim.log.levels.INFO)
            return
        end

        local fname = vim.uri_to_fname(result)
        vim.cmd('edit ' .. fname)
    end)
end

local group = vim.api.nvim_create_augroup('ClangdSourceHeader', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'c', 'cpp', 'h' },
    callback = function(args)
        -- Create buffer-local command
        vim.api.nvim_buf_create_user_command(args.buf, 'ClangdSwitchSourceHeader', switch_source_header, {
            desc = 'Switch between header/source file using clangd'
        })

        -- Create buffer-local key mapping
        vim.keymap.set('n', '<leader>h', switch_source_header, {
            buffer = args.buf,
            desc = 'Switch header/source'
        })
    end
})

-- Terminal functionality
-- This also remains the same - it's independent of plugin management
local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_split_window(opts)
    opts = opts or {}

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    local win_config = {
        relative = 'editor',  -- Relative to the editor window
        width = vim.api.nvim_win_get_width(0),  -- Full width of the editor
        height = vim.api.nvim_win_get_height(0), -- Full height of the editor
        row = 0,  -- Start from the top of the editor
        col = 0,  -- Start from the left side of the editor
        style = 'minimal',  -- No border
        focusable = true,
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    vim.api.nvim_buf_set_option(buf, 'winhighlight', 'NormalFloat:TerminalNormal')
    vim.cmd('highlight TerminalNormal guibg=NONE')

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_split_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command('SpliTerminal', toggle_terminal, {})
vim.keymap.set({'n', 't'},  '<M-->' , toggle_terminal)
