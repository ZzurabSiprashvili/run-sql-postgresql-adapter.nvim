# run-sql-postgresql-adapter.nvim

PostgreSQL adapter for [run-sql.nvim](https://github.com/ZzurabSiprashvili/run-sql.nvim)

## Overview

This plugin provides PostgreSQL database support for `run-sql.nvim`, enabling you to execute SQL queries against PostgreSQL databases directly from Neovim. Query results are automatically copied to your clipboard for easy access.

## Features

- 🔌 Seamless integration with run-sql.nvim
- 🗄️ Full PostgreSQL support via `psql` command-line tool
- 📋 Automatic clipboard copying of query results
- ⚙️ Configurable connection parameters (host, port, database, user, password)
- 📢 User-friendly notifications for query success/failure

## Prerequisites

- Neovim 0.5+
- [run-sql.nvim](https://github.com/ZzurabSiprashvili/run-sql.nvim) plugin installed
- PostgreSQL client (`psql`) installed on your system

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "ZzurabSiprashvili/run-sql.nvim",
  dependencies = {
    "ZzurabSiprashvili/run-sql-postgresql-adapter.nvim",
  },
  config = function()
    require("run-sql").setup({
      adapters = {
        postgresql = require("run-sql-postgresql-adapter"),
      },
    })
  end,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "ZzurabSiprashvili/run-sql.nvim",
  requires = {
    "ZzurabSiprashvili/run-sql-postgresql-adapter.nvim",
  },
  config = function()
    require("run-sql").setup({
      adapters = {
        postgresql = require("run-sql-postgresql-adapter"),
      },
    })
  end,
}
```

## Configuration

The adapter requires the following connection parameters:

- **host**: Database server hostname (default: `localhost`)
- **port**: Database server port (default: `5432`)
- **database**: Database name (required)
- **user**: Database username (required)
- **password**: Database password (required)

These parameters are configured through the run-sql.nvim interface when establishing a connection.

## Usage

Once installed and configured, use the adapter through run-sql.nvim commands:

1. Establish a connection using run-sql.nvim
2. Select the PostgreSQL adapter
3. Provide connection credentials
4. Execute your SQL queries
5. Results are automatically copied to clipboard and displayed in notifications

## How It Works

The adapter:
1. Implements the run-sql.nvim adapter interface with `get_config_schema()`, `connect()`, and `run()` methods
2. Uses the `psql` command-line tool to execute queries
3. Handles authentication via the `PGPASSWORD` environment variable
4. Captures query output and exit codes
5. Provides visual feedback through Neovim notifications

## License

MIT License - See [LICENSE](LICENSE) for details

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Related Projects

- [run-sql.nvim](https://github.com/ZzurabSiprashvili/run-sql.nvim) - The main SQL runner plugin
