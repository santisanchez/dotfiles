require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap(',ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
--
--   -- local format_on_save = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
--   -- vim.api.nvim_create_autocmd('BufWritePre', {
--   --   callback = function()
--   --     vim.cmd [[Format]]
--   --   end,
--   --   group = format_on_save,
--   --   pattern = '*',
--   -- })
-- end
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", ";wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", ";wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", ";wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", ";D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap("n", ";rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", ";a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", ";e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", ";q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", ";f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- require("lsp_signature").on_attach()
	-- require("illuminate").on_attach(client)
	require("nvim-navic").attach(client, bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
	end,
	["rust_analyzer"] = function()
		local has_rust_tools, rust_tools = pcall(require, "rust-tools")
		if has_rust_tools then
			rust_tools.setup({ server = { capabilities = capabilities, on_attach = on_attach } })
		else
			lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
		end
	end,
	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
})
