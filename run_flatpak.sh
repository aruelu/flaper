#!/bin/bash


TMPFILE="/tmp/run_flatpak-"$$".tmp"
LOGFILE="/tmp/run_flatpak-"$$".log"
DIRBIN=$1

echo $GETUSER

yad --list --width=600 --height=400 --column="ラップスクリプト名" \
        --title="flatpakの起動するソフトを選択して下さい" \
        `ls -1 $DIRBIN/* `> $TMPFILE

GETAPP=`cat $TMPFILE | cut -f 1 -d "|" `
if [ "$GETAPP" = "" ]
then
    yad --error --text=選択されていません
else
    GETAPPID=`cat $GETAPP | grep "flatpak" | cut -f 3 -d " " `
    echo "flatpak run "$GETAPPID > $LOGFILE
    flatpak run $GETAPPID &
fi
