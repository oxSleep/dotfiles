require('rose-pine').setup({
    disable_background = true,
	disable_float_background = true,
	disable_italics = true,
})

function ColorMyPencils(color) 
	color = color or "poimandres"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "CurosorLine", { fg = '#5DE4C7' })
	vim.api.nvim_set_hl(1, "CurosorNr", { fg = '#5DE4C7' })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
	vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
end

ColorMyPencils()
