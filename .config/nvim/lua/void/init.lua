require("void.set")
require("void.keymap")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({ "rose-pine/neovim", as = "rose-pine" })
	use { 'olivercederborg/poimandres.nvim' }

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			--{ "williamboman/mason.nvim" },
			--{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
            { "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
    use({"nvim-tree/nvim-web-devicons"})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { { "nvim-lua/plenary.nvim" } } })

	use("mbbill/undotree")
	use("folke/zen-mode.nvim")
end)
