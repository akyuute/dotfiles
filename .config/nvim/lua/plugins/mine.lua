return {
	-- main color scheme
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
			vim.o.background = "dark"
			-- XXX: hi Normal ctermbg=NONE
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
			vim.api.nvim_set_hl(0, "Comment", bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
			vim.api.nvim_set_hl(
				0,
				"LspSignatureActiveParameter",
				{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
			)
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end,
	},

	{
		"preservim/nerdtree",
	},

	-- nice bar at the bottom
	{
		"itchyny/lightline.vim",
		lazy = false, -- also load at start since it's UI
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false
			-- vim.g.lightline.component.lineinfo = '%03l/%03LL %02c/%02CC'
			vim.g.lightline = {
				component = {
					lineinfo = '%-l/%-LL|%02c/%02{strwidth(getline("."))}C',
					-- '%-l/%-LL %-c/%02CC',
				},
				active = {
					left = {
						{ "mode", "paste" },
						{ "readonly", "filename", "modified" },
					},
					right = {
						{},
						{ "fileencoding", "filetype" },
						{ "lineinfo" },
					},
				},
				component_function = {
					filename = "LightlineFilename",
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand("%:t") == "" then
					return "[No Name]"
				else
					return vim.fn.getreg("%")
				end
			end
			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
                function! g:LightlineFilename()
                    return v:lua.LightlineFilenameInLua()
                endfunction
                ]],
				true
			)
		end,
	},

	-- quick navigation
	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "`", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "g`", "<Plug>(leap-backward)")
			-- vim.keymap.set({'n', 'x', 'o'}, 'g`', '<Plug>(leap-from-window)')
		end,
	},

	-- better %
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	-- auto-cd to root of git project
	-- 'airblade/vim-rooter'
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup()
		end,
	},

	-- fzf support for ^p
	--    {
	--        'junegunn/fzf',
	--        dependencies = {
	--            { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
	--        },
	--        config = function()
	--            -- stop putting a giant window over my editor
	--            vim.g.fzf_layout = { down = '~20%' }
	--            -- when using :Files, pass the file list through
	--            --
	--            --   https://github.com/jonhoo/proximity-sort
	--            --
	--            -- to prefer files closer to the current file.
	--            function list_cmd()
	--                local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
	--                if base == '.' then
	--                    -- if there is no current file,
	--                    -- proximity-sort can't do its thing
	--                    return 'fd --type file --follow'
	--                else
	--                    return vim.fn.printf('fd --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
	--                end
	--            end
	--            vim.api.nvim_create_user_command('Files', function(arg)
	--                vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--tiebreak=index' }, arg.bang)
	--            end, { bang = true, nargs = '?', complete = "dir" })
	--        end
	--    },

	--    -- inline function signatures
	--    {
	--        "ray-x/lsp_signature.nvim",
	--        event = "VeryLazy",
	--        opts = {},
	--        config = function(_, opts)
	--            -- Get signatures (and _only_ signatures) when in argument lists.
	--            require "lsp_signature".setup({
	--                doc_lines = 0,
	--                handler_opts = {
	--                    border = "none"
	--                },
	--            })
	--        end
	--    },

	--    -- toml
	--    'cespare/vim-toml',
	--
	--    -- yaml
	--    {
	--        "cuducos/yaml.nvim",
	--        ft = { "yaml" },
	--        dependencies = {
	--            "nvim-treesitter/nvim-treesitter",
	--        },
	--    },
	--
	--    -- rust
	--    {
	--        'rust-lang/rust.vim',
	--        ft = { "rust" },
	--        config = function()
	--            vim.g.rustfmt_autosave = 1
	--            vim.g.rustfmt_emit_files = 1
	--            vim.g.rustfmt_fail_silently = 0
	--            vim.g.rust_clip_command = 'wl-copy'
	--        end
	--    },

	--    -- markdown
	--    {
	--        'plasticboy/vim-markdown',
	--        ft = { "markdown" },
	--        dependencies = {
	--            'godlygeek/tabular',
	--        },
	--        config = function()
	--            -- never ever fold!
	--            vim.g.vim_markdown_folding_disabled = 1
	--            -- support front-matter in .md files
	--            vim.g.vim_markdown_frontmatter = 1
	--            -- 'o' on a list item should insert at same level
	--            vim.g.vim_markdown_new_list_item_indent = 0
	--            -- don't add bullets when wrapping:
	--            -- https://github.com/preservim/vim-markdown/issues/232
	--            vim.g.vim_markdown_auto_insert_bullets = 0
	--        end
	--    },

	-- window transparency
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
}

--[[
-- Bind ^/ to toggle comment
local api = require('Comment.api')
vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
-- Disable autocomment
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})
--]]
