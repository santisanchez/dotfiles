local M = {}

local find_mapping = function (maps, lhs)

  for _, value in ipairs(maps) do
    if value.lhs == lhs then
      return value
    end
  end
end

M._stack = {}

M.push = function (name, mode, mappings)
  local maps = vim.api.nvim_get_keymap(mode)
  local existing_maps = {}
  for lhs, rhs in pairs(mappings) do
    local existing = find_mapping(maps, lhs)
    if existing then
      existing_maps[lhs] = existing
    end
  end

  M._stack[name] = {
    mode = mode,
    existing = existing_maps,
    mappings = mappings
  }

  for lhs, rhs in pairs(mappings) do
    vim.keymap.set(mode,lhs, rhs)
  end
end

M.pop = function (name)
  local state = M._stack[name]
  M._stack[name] = nil

  for lhs, rhs in pairs(state.mappings) do
    if state.existing[lhs] then
      --Handle mappings that existed
    else
      vim.keymap.del(state.mode,lhs,rhs)
    end
  end
end

M.push("debug_mode", "n", {
  [",st"] = "echo 'Hello'",
  [",sz"] = "echo 'Goodbye'",
})

P = function (table)
  print(vim.inspect(table))
end


return M
