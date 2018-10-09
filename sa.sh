#!/bin/bash

# server side assistant

set -e

source ./helper.sh

DOWNLOAD_URL_PREFIX="https://github.com/shadowsocks/shadowsocks-go/releases/download/"
SS_VERSION="1.2.1"
TARBALL="shadowsocks-server.tar.gz"
BIN=shadowsocks-server
CONFIG_FILE=shadowsocks-server.json

CONFIG=$CONFIG_DIR/server_noOTA.json
SERVICE=shadowsocks-server.service

download() {
    echo "Download Shadowsocks Server Binary ..."
    mkdir -p $DOWNLOAD_DIR
    wget "$DOWNLOAD_URL_PREFIX/$SS_VERSION/$TARBALL" -O $DOWNLOAD_DIR/$TARBALL
    tar xfv $DOWNLOAD_DIR/$TARBALL -C $DOWNLOAD_DIR
}

install_ss() {
    echo "Install Shadowsocks Server ..."
    install -v $DOWNLOAD_DIR/$BIN $PREFIX/bin
    install -v $CONFIG $PREFIX/share/$CONFIG_FILE
    install -v $SERVICE_DIR/$SERVICE $SYSTEMD_DIR
    systemctl enable $SERVICE
}

uninstall() {
    echo "Uninstall Shadowsocks Server ..."
    systemctl stop $SERVICE
    systemctl disable $SERVICE
    rm -fv $PREFIX/bin/$BIN
    rm -fv $PREFIX/share/$CONFIG_FILE
    rm -fv $SYSTEMD_DIR/$SERVICE
}

case "$1" in
	"download") download;;
	"install") check_user; install_ss;;
    "restart") check_user; systemctl restart $SERVICE;;
    "stop") check_user; systemctl stop $SERVICE;;
    "status") systemctl status $SERVICE;;
    "uninstall") check_user; uninstall;;
    "clean") rm -rf $DOWNLOAD_DIR;;
	*) print_usage;;
esac
