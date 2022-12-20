local lsp = require('lsp-zero')
local server = { 'sumneko_lua', 'rust_analyzer', 'tsserver', 'html', 'cssls' }

lsp.preset('system-lsp')

vim.diagnostic.config({
    virtual_text = true,
})

lsp.setup_nvim_cmp({
    formatting = {
        -- changing the order of fields so the icon is the first
        fields = { "kind", "abbr", "menu" },

        -- here is where the change happens
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"
            return kind
        end,
    },
})


lsp.setup_servers(server)
lsp.setup()
