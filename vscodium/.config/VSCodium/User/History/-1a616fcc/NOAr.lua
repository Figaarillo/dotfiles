return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    
                                        by figarillo     
    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimpty = true })
  end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
	opts = opts or mru_opts
	items_number = if_nil(items_number, 11)

	local oldfiles = {}
	for _, v in pairs(vim.v.oldfiles) do
		if #oldfiles == items_number then
			break
		end
		local cwd_cond
		if not cwd then
			cwd_cond = true
		else
			cwd_cond = vim.startswith(v, cwd)
		end
		local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
		if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
			oldfiles[#oldfiles + 1] = v
		end
	end
	local target_width = 39

	local tbl = {}
	for i, fn in ipairs(oldfiles) do
		local short_fn
		if cwd then
			short_fn = vim.fn.fnamemodify(fn, ":.")
		else
			short_fn = vim.fn.fnamemodify(fn, ":~")
		end

		if #short_fn > target_width then
			short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
			if #short_fn > target_width then
				short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
			end
		end

		local shortcut = tostring(i + start - 1)

		local file_button_el = file_button(fn, shortcut, short_fn)
		tbl[i] = file_button_el
	end
	return {
		type = "group",
		val = tbl,
		opts = {},
	}
end

local default_header = {
	type = "text",
	val = {
		[[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
		[[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
		[[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
		[[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
		[[██   ████ ███████  ██████    ████   ██ ██      ██]],

		-- [[                               __                ]],
		-- [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		-- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		-- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		-- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		-- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	},
	opts = {
		position = "center",
		hl = "Type",
		-- wrap = "overflow";
	},
}

local section_mru = {
	type = "group",
	val = {
		{
			type = "text",
			val = "Recent files",
			opts = {
				hl = "SpecialComment",
				shrink_margin = false,
				position = "center",
			},
		},
		{ type = "padding", val = 1 },
		{
			type = "group",
			val = function()
				return { mru(0, cdir) }
			end,
			opts = { shrink_margin = false },
		},
	},
}

local buttons = {
	type = "group",
	val = {
		{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
		{ type = "padding", val = 1 },
		dashboard.button("e", "  New file", "<cmd>ene<CR>"),
		dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
		-- dashboard.button("SPC F", "  Live grep"),
		dashboard.button("p", "  Projects", "<cmd>Telescope projects<CR>"),
		dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("u", "  Update plugins", "<cmd>PackerSync<CR>"),
		dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
	},
	position = "center",
}

local end_text = {
	type = "text",
	val = "Quotes",
	opts = {
		position = "center",
		hl = "SpecialComment",
	},
}

local fortune = {
	type = "text",
	val = require("figarillo.plugins.fortune")(),
	opts = {
		position = "center",
		hl = "group",
		-- max_width = 100,
	},
}

local config = {
	layout = {
		{ type = "padding", val = 1 },
		default_header,
		{ type = "padding", val = 2 },
		section_mru,
		{ type = "padding", val = 2 },
		buttons,
		{ type = "padding", val = 1 },
		end_text,
		{ type = "padding", val = 0 },
		fortune,
	},
	opts = {
		margin = 5,
		setup = function()
			vim.cmd("autocmd alpha_temp DirChanged * lua require('alpha').redraw()")
		end,
	},
}

alpha.setup(config)
