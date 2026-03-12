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

function M.execute(connection, query)
  -- Execute SQL query using psql
  vim.notify("Executing PostgreSQL query...")
  -- Implementation here
end

return M
