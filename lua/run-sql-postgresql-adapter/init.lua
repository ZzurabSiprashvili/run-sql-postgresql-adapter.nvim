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
  
  if exit_code == 0 then
    -- Copy output to clipboard
    vim.fn.setreg('+', output)
    vim.notify("\nQuery executed and results copied to clipboard", vim.log.levels.INFO, { title = "PostgreSQL" })
  else
    vim.notify("\nQuery failed:\n" .. output, vim.log.levels.ERROR, { title = "PostgreSQL" })
  end
end

return M
