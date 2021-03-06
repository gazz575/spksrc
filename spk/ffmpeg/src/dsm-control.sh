#!/bin/sh

# Package
PACKAGE="ffmpeg"
DNAME="ffmpeg"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}/bin"
FFMPEG_TARGET="/usr/bin/ffmpeg"
FFPROBE_TARGET="/usr/bin/ffprobe"
FFSERVER_TARGET="/usr/bin/ffserver"

start_daemon ()
{
    if [ ! -e "${FFMPEG_TARGET}" ]; then
        ln -s ${INSTALL_DIR}/ffmpeg ${FFMPEG_TARGET}
    fi
    if [ ! -e "${FFPROBE_TARGET}" ]; then
        ln -s ${INSTALL_DIR}/ffprobe ${FFPROBE_TARGET}
    fi
    if [ ! -e "${FFSERVER_TARGET}" ]; then
        ln -s ${INSTALL_DIR}/ffserver ${FFSERVER_TARGET}
    fi
}

stop_daemon ()
{
    rm -f ${FFMPEG_TARGET}
    rm -f ${FFPROBE_TARGET}
    rm -f ${FFSERVER_TARGET}
}

daemon_status ()
{
    if [ -e ${FFMPEG_TARGET} ]; then
        return
    fi
    return 1
}

case $1 in
    start)
        if daemon_status; then
            echo ${DNAME} is already running
        else
            echo Starting ${DNAME} ...
            start_daemon
        fi
		;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
        else
            echo ${DNAME} is not running
        fi
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    log)
        exit 1
        ;;
    *)
        exit 1
        ;;
esac
