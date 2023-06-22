#!/bin/bash


TMPFILE="/tmp/flatpak_uninstall-"$$".tmp"
LOGFILE="/tmp/flatpak_uninstall-"$$".log"
DIRBIN=$1

yad --list --width=600 --height=400 --column="ラップスクリプト名" \
        --title="flatpakの削除するソフトを選択して下さい" \
         `ls -1 $DIRBIN/* `> $TMPFILE

GETAPP=`cat $TMPFILE | cut -f 1 -d "|"`
if [ "$GETAPP" = "" ]
then
    yad --error  --text=選択されていません
else
    (
    yad --info --on-top --no-buttons --title="削除中" --text="このウィンドウが自動で閉じるまで待って下さい" &
    GETPID=`echo $!`
    GETAPPID=`cat $GETAPP | grep "flatpak" | cut -f 3 -d " "`
    echo "flatpak uninstall -y "$GETAPPID 
    echo "" 
    flatpak uninstall -y $GETAPPID 
    rm -f $GETAPP
    kill $GETPID
    ) 2>&1 | tee -a $LOGFILE | \
            yad --text-info --title="「flatpakのソフト削除」の処理結果" \
                   --width=600  --height=400   \
                   --tail  --button=OK:0  --center --checkbox="処理終了を確認"

fi
