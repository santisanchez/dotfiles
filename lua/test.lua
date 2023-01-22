local function get_class_attributes()
    -- Get the current cursor position
    local cursor_position = {
        line = vim.api.nvim_win_get_cursor(0)[1],
        character = vim.api.nvim_win_get_cursor(0)[2]
    }

    -- Send a textDocument/definition request to the LSP client
    local request_params = {
        textDocument = { uri = vim.uri_from_bufnr(0) },
        position = cursor_position
    }
    local response = vim.lsp.buf_request_sync(0, "textDocument/completion", request_params)
    print(vim.inspect(response))

    -- Extract the attributes of the class from the response
    local class_definition = response.result
    if not class_definition then
        return {}
    end

    -- Extract the attributes of the class from the definition
    local class_line = vim.api.nvim_buf_get_lines(0, class_definition.range.start.line,
        class_definition.range.start.line + 1, false)[1]
    local attributes = {}
    for name, type, access_modifier in class_line:gmatch("(%w+)%s+(%w+)%s+(%w+)") do
        table.insert(attributes, { name = name, type = type, access_modifier = access_modifier })
    end
    return attributes
end

-- vim.keymap.set('i', '<leader>gca', get_class_attributes, { noremap = true, silent = true })

