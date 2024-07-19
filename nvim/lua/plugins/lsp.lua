-- Initialize nvim-cmp.
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Set up nvim-cmp.
cmp.setup({
    snippet = {
        expand = function(args)
            -- Use your preferred snippet engine here
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- Add other sources here if needed
    })
})

-- Setup language servers.
local lspconfig = require('lspconfig')

-- Make the LSP client capabilities compatible with nvim-cmp.
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup python-lsp-server
lspconfig['pylsp'].setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Custom on_attach function
        -- Define key mappings or other settings specific to the language server
    end,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 88,
                },
            },
        },
    },
}

-- Setup clangd for C++ and C
lspconfig['clangd'].setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Custom on_attach function
        -- Define key mappings or other settings specific to the language server
    end,
}

-- Setup jdtls for Java
lspconfig['jdtls'].setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Custom on_attach function
        -- Define key mappings or other settings specific to the language server
    end,
    cmd = { '/home/getname/.local/share/nvim/mason/packages/jdtls/bin/jdtls' },  -- Update with the correct path to your jdtls
    root_dir = function(fname)
        return lspconfig.util.root_pattern('pom.xml', 'build.gradle', '.git')(fname) or vim.fn.getcwd()
    end,
}

