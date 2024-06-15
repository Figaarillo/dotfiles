local status, dracula = pcall("dracula")
if not status then
	return
end

dracula.setup({
	-- show the '~' characters after the end of buffers
	show_end_of_buffer = true, -- default false
	-- use transparent background
	transparent_bg = false, -- default false
	-- set custom lualine background color
	lualine_bg_color = "#44475a", -- default nil
	-- set italic comment
	italic_comment = true, -- default false
	-- overrides the default highlights see `:h synIDattr`
	overrides = {
		-- Examples
		-- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
		-- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
		-- Nothing = {} -- clear highlight of Nothing
	},
})
