-- =================== Speed up loading Lua modules =================
vim.loader.enable()

-- ==============+=============== Init ==============================
vim.cmd([[
	set guifont=Operator\ Mono\ SSm\ Lig:h3.5
]])
-- ============================= Neovide ============================
-- @diagnostic disable: undefined-global
vim.cmd([[
	if exists("g:neovide")
		set guifont=Operator\ Mono\ SSm\ Lig:h3.5
    " set guifont=VictorMono\ Nerd\ NF\ Semi-Bold\ Italic:4
		" set guifont=CaskaydiaCove\ Nerd\ Font\ Bold:h4
		let g:neovide_scale_factor = 1
		let g:neovide_cursor_vfx_mode = "pixiedust"
		let g:neovide_remember_window_size = v:true
    let g:neovide_transparency = 0.85
    let g:neovide_background_color = '#0B0E14'
	endif
]])
