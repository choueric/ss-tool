#!/bin/bash

# local side assistant

set -e

source ./helper.sh

DOWNLOAD_URL_PREFIX="https://github.com/shadowsocks/shadowsocks-go/releases/download/"
SS_VERSION="1.1.5"
TARBALL="shadowsocks-local-linux64-1.1.5.gz"
BIN=shadowsocks-local
ORI_BIN=$BIN-linux64-$SS_VERSION
CONFIG_FILE=shadowsocks-local.json

CONFIG=$CONFIG_DIR/local_linode.json
SERVICE=shadowsocks-local.service

download() {
    echo "Download Shadowsocks Local Binary ..."
    mkdir -p $DOWNLOAD_DIR
    wget "$DOWNLOAD_URL_PREFIX/$SS_VERSION/$TARBALL" -O $DOWNLOAD_DIR/$TARBALL
    gunzip -fv $DOWNLOAD_DIR/$TARBALL
}

install_ss() {
    echo "Install Shadowsocks Local ..."
    install -v $DOWNLOAD_DIR/$ORI_BIN $PREFIX/bin/$BIN
    install -v $CONFIG $PREFIX/share/$CONFIG_FILE
    install -v $SERVICE_DIR/$SERVICE $SYSTEMD_DIR
    systemctl enable $SERVICE
}

uninstall() {
    echo "Uninstall Shadowsocks Local ..."
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
