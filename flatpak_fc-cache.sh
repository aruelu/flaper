#!/bin/bash


TMPFILE="/tmp/flatpak_fc-cache-"$$".tmp"
LOGFILE="/tmp/flatpak_fc-cache-"$$".log"
DIRBIN=$1


yad --list --width=600 --height=400 --column="ラップスクリプト名" \
        --title="flatpakの文字化け改善をしたいソフトを選択して下さい" \
        `ls -1 $DIRBIN/* `> $TMPFILE

GETAPP=`cat $TMPFILE | cut -f 1 -d "|" `
if [ "$GETAPP" = "" ]
then
    yad --error  --text=選択されていません
else
    (
    echo "プログラム名:" 
    echo $GETAPP 
    echo "" 
    yad --info --on-top --no-buttons --title="処理中" --text="このウィンドウが自動で閉じるまで待って下さい" &
    GETPID=`echo $!`
    GETAPPID=`cat $GETAPP | grep "flatpak" | cut -f 3 -d " "`
    flatpak run --command=fc-cache $GETAPPID -f -v 
    kill $GETPID
    ) 2>&1 | tee -a $LOGFILE | \
             yad --text-info --title="「flatpakの文字化け改善」の処理結果" \
                    --width=600  --height=400   \
                    --tail  --button=OK:0  --center --checkbox="処理終了を確認"
fi
