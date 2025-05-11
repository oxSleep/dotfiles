-- Keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>p" , "<C-^>")
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Options
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- Options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.have_nerdfont = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.clipboard="unnamedplus"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.pumheight = 12
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 11 
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.winborder = 'rounded'
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = '#ifdef,#endif'

-- Shell
--vim.opt.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
--vim.opt.shellcmdflag = '-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'
--vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
--vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
--vim.opt.shellquote = ''
--vim.opt.shellxquote = ''


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    install = { colorscheme = { "default" } },
    checker = { enabled = false },
    spec = {
        -- Tressitter
        {
            'nvim-treesitter/nvim-treesitter',
            event = { "BufReadPost", "BufNewFile" },
            build = ':TSUpdate',
            main = 'nvim-treesitter.configs',
            opts = {
                auto_install = false,
                highlight = {
                    enable = true,
                },
            },
        },
        -- Completion
        {
            "saghen/blink.cmp",
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = "1.*",
            opts = {
                completion = { menu = { auto_show = false} },
                keymap = {
                    preset = "none",
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
                    default = { "buffer", "snippets", "path" }
                },
            },
        },
        -- Align
        { 'echasnovski/mini.align',
            version = false,
            config = true,
        },
        -- Colorscheme
        {
            "slugbyte/lackluster.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                local lackluster = require("lackluster")
                local color = lackluster.color
                lackluster.setup({
                    tweak_syntax = {
                        string = "default",
                        string_escape = "default",
                        comment = color.green,
                        type = color.blue,
                        keyword = color.orange,
                        keyword_return = color.orange,
                        keyword_exception = "default",
                    },
                    tweak_background = {
                        normal = 'none',
                        menu   = 'none',
                        popup  = 'none'
                    }
                })
                vim.cmd.colorscheme("lackluster-hack")
                vim.api.nvim_set_hl(0, "Normal", { bg = nil, ctermbg = nil })
            end,
        },
    },
})

-- LSP
vim.lsp.config.clangd = {
    cmd = {
        "D:\\Scoop\\apps\\clangd\\current\\bin\\clangd.exe",
        "--background-index",
    },
    root_dir = vim.fn.getcwd(),
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
}
vim.lsp.enable({'clangd'})


vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/codeAction") then
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
                buffer = ev.buf,
                desc = "LSP: Code Action",
            })
        end
    end,
})

-- Switch source/header (c, cpp)
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
    pattern = { 'c', 'cpp', 'h' },  -- Add 'h' if you want it available in header files
    callback = function(args)
        -- Create buffer-local command
        vim.api.nvim_buf_create_user_command(args.buf, 'ClangdSwitchSourceHeader', switch_source_header, {
            desc = 'Switch between header/source file using clangd'
        })

        -- Optional: Create buffer-local key mapping
        vim.keymap.set('n', '<leader>h', switch_source_header, {
            buffer = args.buf,
            desc = 'Switch header/source'
        })
    end
})

-- Terminal
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
        relative = "editor",  -- Relative to the editor window
        width = vim.api.nvim_win_get_width(0),  -- Full width of the editor
        height = vim.api.nvim_win_get_height(0), -- Full height of the editor
        row = 0,  -- Start from the top of the editor
        col = 0,  -- Start from the left side of the editor
        style = "minimal",  -- No border
        focusable = true,
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    vim.api.nvim_buf_set_option(buf, 'winhighlight', 'NormalFloat:TerminalNormal')  -- Highlight groups for transparency
    vim.cmd("highlight TerminalNormal guibg=NONE")

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_split_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command("SpliTerminal", toggle_terminal, {})
vim.keymap.set({"n", "t"},  "<M-->" , toggle_terminal)
vim.keymap.set('n', '<F5>', ':!.\\build.bat<CR>', { noremap = true, silent = false })
