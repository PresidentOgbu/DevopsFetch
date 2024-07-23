#!/bin/bash

# Display all Active Ports and Services
display_ports() {
    echo "Active Ports and Services:"
    netstat -tuln | awk 'NR>2 {print $1, $4, $7}' | column -t
}

# Provide Detailed information about a specific port 
display_port_details() {
    local port_number=$1
    echo "Details for port $port_number:"
    netstat -tuln | grep ":$port_number" | awk '{print $1, $4, $7}' | column -t
}

# List all docker images and containers 
list_docker() {
    echo "Docker Images:"
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}"

    echo "Docker Containers:"
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
}

# Provide detailed information about a specific docker container
docker_container_details() {
    local container_name=$1
    echo "Details for Docker container $container_name:"
    docker inspect $container_name | jq '.[] | {Name: .Name, State: .State, Config: .Config}'
}

# Display all Nginx domains and their ports
list_nginx_domains() {
    echo "Nginx Domains and Ports:"
    grep -E -h "server_name" /etc/nginx/sites-enabled/* | sed 's/.*server_name \(.*\);/server_name: \1/' | column -t
}

# Provide detailed configuration information for a specific domain
nginx_domain_details() {
    local domain=$1
    echo "Details for Nginx domain $domain:"

    # get the file
    local file=$(grep -l "server_name $domain;" /etc/nginx/sites-enabled/*)

    # get port
    local port=$(grep -E "listen" $file | awk '{print $2}' | head -1)

    # get root
    local root=$(grep -E "root" $file | awk '{print $2}' | head -1)

    # get index
    local index=$(grep -E "index" $file | awk '{print $2}' | head -1)

    # get server_name
    local server_name=$(grep -E "server_name" $file | awk '{print $2}' | head -1)

    echo "Port: $port"
    echo "Root: $root"
    echo "Index: $index"
    echo "Server Name: $server_name"
}

# List all users and their last login times
list_users() {
    echo "Users and Last Login Times:"
    lastlog | column -t
}

# Provide detailed information about a specific user
user_details() {
    local username=$1
    echo "Details for user $username:"
    finger $username
}

# Display activities within a specified time range
display_activities_in_time_range() {
    local start_time=$1
    local end_time=$2
    echo "Activities from $start_time to $end_time:"
    journalctl --since="$start_time" --until="$end_time" | less
}

# Instructions for Display Usage
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --port                Display all active ports and services"
    echo "  -p <port_number>          Display detailed information about a specific port"
    echo "  -d, --docker              List all Docker images and containers"
    echo "  -d <container_name>       Display detailed information about a specific Docker container"
    echo "  -n, --nginx               Display all Nginx domains and their ports"
    echo "  -n <domain>               Display detailed configuration information for a specific Nginx domain"
    echo "  -u, --users               List all users and their last login times"
    echo "  -u <username>             Display detailed information about a specific user"
    echo "  -t, --time <start> <end>  Display activities within a specified time range"
    echo "  -h, --help                Display help message"
}

# Parse command-line arguments
case $1 in
    -p|--port)
        if [ -z "$2" ]; then
            display_ports
        else
            display_port_details $2
        fi
        ;;
    -d|--docker)
        if [ -z "$2" ]; then
            list_docker
        else
            docker_container_details $2
        fi
        ;;
    -n|--nginx)
        if [ -z "$2" ]; then
            list_nginx_domains
        else
            nginx_domain_details $2
        fi
        ;;
    -u|--users)
        if [ -z "$2" ]; then
            list_users
        else
            user_details $2
        fi
        ;;
    -t|--time)
        if [ -z "$3" ]; then
            echo "Error: Time range requires start and end times."
            exit 1
        else
            display_activities_in_time_range $2 $3
        fi
        ;;
    -h|--help)
        display_help
        ;;
    *)
        echo "Error: Invalid option."
        display_help
        exit 1
        ;;
esac