# DevopsFetch


## Introduction
DevopsFetch is a tool developed in bash, it's designed for server information monitoring and retrieval.

It has been setup to display active ports, user logins, Nginx configurations, Docker images, and the status of the container.

DevopsFetch includes a systemd service for logging and continuous monitoring.

## Features
- Display all active ports and services
- Provide detailed information about a specific port
- List all Docker images and containers
- Provide detailed information about a specific Docker container
- Display all Nginx domains and their ports
- Provide detailed configuration information for a specific Nginx domain
- List all users and their last login times
- Provide detailed information about a specific user
- Display activities within a specified time range
- Continuous monitoring and logging with log rotation

## Prerequisites
Ensure the following packages are installed on your system:
- `ss`
- `docker.io`
- `nginx`
- `journalctl`
- `finger`
- `jq`

## Installation

### Step 1 : Create a folder in desktop and Cd into it using prefeered IDE.
```bash
   cd devopsfetch
   ```
### Step 2  : Install the necccesary dependencies
```bash
   sudo ./install.sh
   ```


### Command-line Options

- `-p, --port` : Display all active ports and services.
- `-p <port_number>` : Display detailed information about a specific port.
- `-d, --docker` : List all Docker images and containers.
- `-d <container_name>` : Display detailed information about a specific Docker container.
- `-n, --nginx` : Display all Nginx domains and their ports.
- `-n <domain>` : Display detailed configuration information for a specific Nginx domain.
- `-u, --users` : List all users and their last login times.
- `-u <username>` : Display detailed information about a specific user.
- `-t, --time <start> <end>` : Display activities within a specified time range.
- `-h, --help` : Display usage instructions.

### Display Active Ports

To display all active ports and services, run:
```bash
./devopsfetch.sh -p
```

### Port Information

To provide detailed information about a specific port, run:
```bash
./devopsfetch.sh -p <port_number>
```
Example:
```bash
./devopsfetch.sh -p 80
```

### Docker Information

To list all Docker images and containers, run:
```bash
./devopsfetch.sh -d
```

To provide detailed information about a specific Docker container, run:
```bash
./devopsfetch.sh -d <container_name>
```
Example:
```bash
./devopsfetch.sh -d my_container
```

### Nginx Information

To display all Nginx domains and their ports, run:
```bash
./devopsfetch.sh -n
```

To provide detailed configuration information for a specific Nginx domain, run:
```bash
./devopsfetch.sh -n <domain>
```
Example:
```bash
./devopsfetch.sh -n example.com
```

### User Logins

To list all users and their last login times, run:
```bash
./devopsfetch.sh -u
```

To provide detailed information about a specific user, run:
```bash
./devopsfetch.sh -u <username>
```
Example:
```bash
./devopsfetch.sh -u myuser
```

### Time Range Activities

To display activities within a specified time range, run:
```bash
./devopsfetch.sh -t "<start_time>" "<end_time>"
```
Example:
```bash
./devopsfetch.sh -t "2024-07-21 00:00:00" "2024-07-22 00:00:00"
```

## Logging

Logs are stored in the `/var/log/devopsfetch.log` directory. Log rotation is implemented to manage log file size. Log rotation is configured to rotate logs daily, keeping up to 7 days of logs.

## Help

To display the help message with usage instructions, run:
```bash
./devopsfetch.sh -h
```



