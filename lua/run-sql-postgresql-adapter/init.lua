local M = {}

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
