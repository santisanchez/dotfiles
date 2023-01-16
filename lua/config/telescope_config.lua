local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local config = require("telescope.config")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local previewers = require("telescope.previewers")
local utils = require("telescope.utils")
local conf = require("telescope.config").values
local telescope_builtin = require("telescope.builtin")
local Path = require("plenary.path")

local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function use_normal_mapping(key)
    return function()
        vim.cmd.stopinsert()
        local key_code = vim.api.nvim_replace_termcodes(key, true, false, true)
        vim.api.nvim_feedkeys(key_code, "m", false)
    end
end

require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
            width = 0.8,
            horizontal = {
                mirror = false,
                prompt_position = "top",
                preview_cutoff = 120,
                preview_width = 0.5,
            },
            vertical = {
                mirror = false,
                prompt_position = "top",
                preview_cutoff = 120,
                -- preview_width = 0.5,
            },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules/*", "public/*" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        dynamic_preview_title = true,
        winblend = 0,
        border = {},
        borderchars = {
            { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            -- prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
            -- results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
            -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
            -- fzf-preview style
            prompt = { "─", "│", " ", "│", "┌", "┬", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
            preview = { "─", "│", "─", " ", "─", "┐", "┘", "─" },
        },
        color_devicons = true,
        use_less = true,
        scroll_strategy = "cycle",
        set_env = { ["COLORTERM"] = "truecolor" }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
        -- file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        -- grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        -- qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            n = {
                ["<C-t>"] = action_layout.toggle_preview,
                ["<C-v>"] = use_normal_mapping("<C-v>"),
                ["<C-s>"] = use_normal_mapping("<C-s>"),
                ["<CR>"] = use_normal_mapping("<CR>"),
            },
            i = {
                ["<Esc>"] = actions.close,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-t>"] = action_layout.toggle_preview,
                ["<C-x>"] = false,
                -- ["<C-s>"] = actions.select_horizontal,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<C-q>"] = actions.send_selected_to_qflist,
                -- ["<CR>"] = actions.select_default + actions.center,
                ["<C-g>"] = custom_actions.multi_selection_open,
                ["<C-v>"] = custom_actions.multi_selection_open_vertical,
                ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
                -- ["<C-t>"] = custom_actions.multi_selection_open_tab,
                ["<CR>"] = custom_actions.multi_selection_open,
            },
        },
        history = { path = vim.fn.stdpath("state") .. "/databases/telescope_history.sqlite3", limit = 100 },
    },
    extensions = {
        media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" }, -- filetypes whitelist
            find_cmd = "rg", -- find command
        },
        arecibo = {
            ["selected_engine"] = "google",
            ["url_open_command"] = "xdg-open",
            ["show_http_headers"] = false,
            ["show_domain_icons"] = false,
        },
        frecency = {
            db_root = vim.fn.stdpath("state"),
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
            db_safe_mode = false,
            auto_validate = true,
        },
        project = {
            base_dirs = (function()
                local dirs = {}
                local function file_exists(fname)
                    local stat = vim.loop.fs_stat(vim.fn.expand(fname))
                    return (stat and stat.type) or false
                end

                if file_exists("~/.ghq") then
                    dirs[#dirs + 1] = { "~/.ghq", max_depth = 5 }
                end
                if file_exists("~/Workspace") then
                    dirs[#dirs + 1] = { "~/Workspace", max_depth = 3 }
                end
                if #dirs == 0 then
                    return nil
                end
                return dirs
            end)(),
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case",
        },
    },
})

local function remove_duplicate_paths(tbl, cwd)
    local res = {}
    local hash = {}
    for _, v in ipairs(tbl) do
        local v1 = Path:new(v):normalize(cwd)
        if not hash[v1] then
            res[#res + 1] = v1
            hash[v1] = true
        end
    end
    return res
end

local function join_uniq(tbl, tbl2)
    local res = {}
    local hash = {}
    for _, v1 in ipairs(tbl) do
        res[#res + 1] = v1
        hash[v1] = true
    end

    for _, v in pairs(tbl2) do
        if not hash[v] then
            table.insert(res, v)
        end
    end
    return res
end

local function filter_by_cwd_paths(tbl, cwd)
    local res = {}
    local hash = {}
    for _, v in ipairs(tbl) do
        if v:find(cwd, 1, true) then
            local v1 = Path:new(v):normalize(cwd)
            if not hash[v1] then
                res[#res + 1] = v1
                hash[v1] = true
            end
        end
    end
    return res
end

local function requiref(module)
    require(module)
end

telescope_builtin.my_mru = function(opts)
    local get_mru = function(opts2)
        local res = pcall(requiref, "telescope._extensions.frecency")
        if not res then
            return vim.tbl_filter(function(val)
                return 0 ~= vim.fn.filereadable(val)
            end, vim.v.oldfiles)
        else
            local db_client = require("telescope._extensions.frecency.db_client")
            db_client.init()
            -- too slow
            -- local tbl = db_client.get_file_scores(opts, vim.fn.getcwd())
            local tbl = db_client.get_file_scores(opts2)
            local get_filename_table = function(tbl2)
                local res2 = {}
                for _, v in pairs(tbl2) do
                    res2[#res2 + 1] = v["filename"]
                end
                return res2
            end
            return get_filename_table(tbl)
        end
    end
    local results_mru = get_mru(opts)
    local results_mru_cur = filter_by_cwd_paths(results_mru, vim.loop.cwd())

    local show_untracked = vim.F.if_nil(opts.show_untracked, true)
    local recurse_submodules = vim.F.if_nil(opts.recurse_submodules, false)
    if show_untracked and recurse_submodules then
        error("Git does not suppurt both --others and --recurse-submodules")
    end
    local cmd = {
        "git",
        "ls-files",
        "--exclude-standard",
        "--cached",
        show_untracked and "--others" or nil,
        recurse_submodules and "--recurse-submodules" or nil,
    }
    local results_git = utils.get_os_command_output(cmd)

    local results = join_uniq(results_mru_cur, results_git)

    pickers
        .new(opts, {
            prompt_title = "MRU",
            finder = finders.new_table({
                results = results,
                entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
            }),
            -- default_text = vim.fn.getcwd(),
            sorter = conf.file_sorter(opts),
            previewer = conf.file_previewer(opts),
        })
        :find()
end

telescope_builtin.grep_prompt = function(opts)
    vim.ui.input({ prompt = "Grep String > " }, function(input)
        if input == nil then
            return
        end
        opts.search = input
        telescope_builtin.my_grep(opts)
    end)
end

telescope_builtin.my_grep = function(opts)
    require("telescope.builtin").grep_string({
        opts = opts,
        prompt_title = "grep_string: " .. opts.search,
        search = opts.search,
        use_regex = true,
    })
end

telescope_builtin.my_grep_in_dir = function(opts)
    vim.ui.input({ prompt = "Grep String > " }, function(input)
        if input == nil then
            return
        end
        opts.search = input
        opts.search_dirs = {}
        vim.ui.input({ prompt = "Target Directory > " }, function(input_dir)
            if input_dir == nil then
                return
            end
            opts.search_dirs[1] = input_dir
            require("telescope.builtin").grep_string({
                opts = opts,
                prompt_title = "grep_string(dir): " .. opts.search,
                search = opts.search,
                search_dirs = opts.search_dirs,
            })
        end)
    end)
end

telescope_builtin.memo = function(opts)
    require("telescope.builtin").find_files({
        opts = opts,
        prompt_title = "MemoList",
        find_command = { "find", vim.g.memolist_path, "-type", "f", "-exec", "ls", "-1ta", "{}", "+" },
    })
end

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><Leader>', require('telescope.builtin').oldfiles,
    { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set("n", "<Leader>e", "<Cmd>Telescope my_mru<CR>", { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>sl", "<Cmd>Telescope laravel<CR>", { noremap = true, silent = true })

vim.keymap.set("v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]<Leader>",
--     "<Cmd>Telescope find_files<CR>",
--     { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap("n", "<Leader>;", "<Cmd>Telescope git_files<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder];", "<Cmd>Telescope git_files<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap(
--     "n",
--     "<Leader>.",
--     "<Cmd>Telecwoc diagnosticsscope find_files<CR>",
--     { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder].", "<Cmd>Telescope my_mru<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Leader>,", "<Cmd>Telescope grep_prompt<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder],", "<Cmd>Telescope grep_prompt<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]>", "<Cmd>Telescope my_grep_in_dir<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap(
--     "v",
--     "[_FuzzyFinder],",
--     "y:Telescope my_grep search=<C-r>=escape(@\", '\\.*$^[] ')<CR>",
--     { noremap = true }
-- )
-- vim.api.nvim_set_keymap(
--     "n",
--     "<Leader>/",
--     ":<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>",
--     { noremap = true }
-- )
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]/",
--     ":<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>",
--     { noremap = true }
-- )
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]s", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]b", "<Cmd>Telescope buffers<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]h", "<Cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]c", "<Cmd>Telescope commands<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]t", "<Cmd>Telescope treesitter<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]q", "<Cmd>Telescope quickfix<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]l", "<Cmd>Telescope loclist<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]m", "<Cmd>Telescope marks<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]r", "<Cmd>Telescope registers<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]*", "<Cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]f",
--     "<Cmd>Telescope file_browser file_browser<CR>",
--     { noremap = true, silent = true }
-- )
-- -- git
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]gs",
--     "<Cmd>lua require('telescope.builtin').git_status()<CR>",
--     { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]gc",
--     "<Cmd>lua require('telescope.builtin').git_commits()<CR>",
--     { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]gC",
--     "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>",
--     { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]gb",
--     "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
--     { noremap = true, silent = true }
-- )
-- -- extension
-- vim.api.nvim_set_keymap(
--     "n",
--     "[_FuzzyFinder]S",
--     "<Cmd>lua require('telescope').extensions.arecibo.websearch()<CR>",
--     { noremap = true, silent = true }
-- )
-- -- coc
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]cd", "<Cmd>Telescope coc diagnostics<CR>", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap("n", "[_FuzzyFinder]:", "<Cmd>Telescope command_history<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("c", "<C-t>", "<BS><Cmd>Telescope command_history<CR>", { noremap = true, silent = true })
