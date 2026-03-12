local M = {}

function M.get_config_schema()
  return {
    { name = "host", prompt = "Host: ", default = "localhost" },
    { name = "port", prompt = "Port: ", default = "5432" },
    { name = "database", prompt = "Database: " },
    { name = "user", prompt = "User: " },
    { name = "password", prompt = "Password: " },
  }
end

function M.connect(config)
  -- config contains: host, port, database, user, password
  return {
    adapter = "postgresql",
    config = config,
  }
end

function M.run(connection, query)
  local config = connection.config
  
  -- Build psql command
  local cmd = string.format(
    "PGPASSWORD='%s' psql -h %s -p %s -U %s -d %s -c %s",
    config.password,
    config.host,
    config.port,
    config.user,
    config.database,
    vim.fn.shellescape(query)
  )
  
  -- Execute the query
  local output = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error
  
  -- Create or reuse buffer for results
  local bufname = "SQL Results"
  local bufnr = vim.fn.bufnr(bufname)
  
  if bufnr == -1 then
    -- Create new buffer
    bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(bufnr, bufname)
  end
  
  -- Set buffer options
  vim.bo[bufnr].filetype = "markdown"
  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].modifiable = false
  
  -- Prepare markdown content
  local lines = {}
  table.insert(lines, "# SQL Query Results")
  table.insert(lines, "")
  table.insert(lines, "**Connection:** " .. connection.name)
  table.insert(lines, "**Database:** " .. config.database)
  table.insert(lines, "")
  table.insert(lines, "## Query")
  table.insert(lines, "```sql")
  for line in query:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  table.insert(lines, "```")
  table.insert(lines, "")
  
  if exit_code == 0 then
    table.insert(lines, "## Results")
    table.insert(lines, "```")
    for line in output:gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end
    table.insert(lines, "```")
  else
    table.insert(lines, "## Error")
    table.insert(lines, "```")
    table.insert(lines, output)
    table.insert(lines, "```")
  end
  
  -- Set buffer content
  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].modified = false
  
  -- Open buffer in a split
  vim.cmd("vsplit")
  vim.api.nvim_set_current_buf(bufnr)
  
  vim.notify("\nQuery executed")
end

return M
