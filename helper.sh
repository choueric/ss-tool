PREFIX=/usr/local
SYSTEMD_DIR=/lib/systemd/system

CONFIG_DIR=./config
SERVICE_DIR=./service
DOWNLOAD_DIR="`pwd`/downloads"

check_user() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root." 1>&2
        exit 1
    fi
}

print_usage() {
    echo "Usage: $0 <cmd>"
    echo "  cmd: download, install, restart, uninstall, clean"
}
