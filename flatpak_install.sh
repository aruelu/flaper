#!/bin/bash

TMPFILE="/tmp/appinstall_flatpak-"$$".tmp"
LOGFILE="/tmp/appinstall_flatpak-"$$".log"
CONFFILE="./flatpak.conf"
DIRBIN=$1

. ./flaper_function

yad --list --width=600 --height=400 --column=ID \
        --column=プログラム名 --column=説明 --column=パッケージ名 \
        --title="flatpakでインストールするソフトを選択して下さい" \
         `cat $CONFFILE` > $TMPFILE

RETID=`cat $TMPFILE`
echo $RETID
if [ "$RETID" = "" ]
then
    yad --error  --text=ソフトが選択されていません
else
    TMPLIST=`echo $RETID`
    echo "TEMPLIST="$TMPLIST
    APPNAME=`echo $TMPLIST | cut -f 2 -d "|"`
    GETREMOTES=`echo $TMPLIST | cut -f 4 -d "|" | cut -f 1 -d ","`
    GETAPPID=`echo $TMPLIST | cut -f 4 -d "|" | cut -f 2 -d ","`
    echo "LOGFILE=""$LOGFILE"
    echo "DIRBIN=""$DIRBIN"
    echo "APPNAME="$APPNAME
    echo "GETREMOTES="$GETREMOTES
    echo "GETAPPID="$GETAPPID
    flatpakinstall $LOGFILE $DIRBIN $APPNAME $GETREMOTES $GETAPPID 
fi
