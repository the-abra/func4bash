# Bash Utilities Library

Welcome to a collection of libraries containing various functions written in Bash! This project aims to shorten and make more useful various special codes that are normally long and hard to remember.

## Installation 🛠️

    bash -c "$(curl -sSfL https://raw.githubusercontent.com/func4bash/bash-utilities-library/main/setup.sh)" && \
    source /lib/func4bash/log.lib && log.done "Installation"

## Usage 

    # Importing
    source /lib/func4bash/log.lib    # this includes functions
    source /lib/func4bash/colors.lib # this includes variables
    
    # Calling
    log.info "Hello func4bash :D"                            # Function includeded lib usage.
    echo -e "${RED} red color ${RESET_COLOR} default color." # Variable includeded lib usage. 


## Libraries
- **colors.lib**: Color codes and style functions for terminal output
- **paths.lib**: Functions to shorten default and frequently used file paths
- **datetime.lib**: Date and time formatting, calculation functions
- **textprocessing.lib**: Text editing, search and replace functions
- **fileoperations.lib**: File read, write, copy and delete operations
- **network.lib**: Network related operations and IP address query functions
- **sysinfo.lib**: Functions for querying system status and information
- **userinput.lib**: Getting information from the user, menus and selection operations
- **static_process_bar.lib**: Simple process bar and effects in terminal
- **sqlite3.lib**: Simple database operations (SQLite)
- **http.lib**: Making requests such as HTTP GET, POST
- **json.lib**: Read and write JSON data
- **log.lib**: Logging operations and log file management
- **permissions.lib**: Check and change file and directory permissions
