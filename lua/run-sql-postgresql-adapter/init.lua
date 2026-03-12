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
  -- For now, just log the query
  vim.notify("PostgreSQL adapter running query:\n" .. query, vim.log.levels.INFO)
end

return M
