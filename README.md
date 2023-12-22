# SSH Connection Manager Script

This Bash script provides a user-friendly interface for managing SSH connections. It allows users to add, delete, and connect to SSH servers by maintaining a list of server details.

## Features

- **Add New SSH Connection**: Allows you to add a new SSH connection with a unique name and address (user@ip).
- **Delete Existing SSH Connection**: Enables you to delete an existing connection from the list.
- **Connect to an SSH Server**: Facilitates quick SSH connection to a server from the saved list.

## How It Works

- The script stores the SSH connection details in `data.sh` located at `/home/elijah/Documents/git-script/App-ssh/`.
- It uses associative arrays (`SERVERS`) and indexed arrays (`SERVER_KEYS`) to manage the connections.
- A menu-driven interface is provided for interaction.

## Prerequisites

- Bash shell environment.
- SSH client installed on your system.
- `data.sh` file should exist in the specified path or will be created on adding the first connection.

## Usage

1. **Starting the Script**:
   Run the script using the Bash interpreter:
   ```bash
   bash script_name.sh

