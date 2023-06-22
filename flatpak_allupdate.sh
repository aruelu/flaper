#!/bin/bash


LOGFILE="/tmp/flatpak_allupdate-"$$".log"

(
yad --info --on-top --no-buttons --title="flatpakの全てのソフトを更新中" --text="このウィンドウが自動で閉じるまで待って下さい" &
GETPID=`echo $!`
echo "flatpak update -y" 
echo ""$GETAPPID 
flatpak update -y 
kill $GETPID
) 2>&1 | tee -a $LOGFILE | \
        yad --text-info --title="「flatpakの全てのソフト更新」の処理結果" \
               --width=600  --height=400   \
               --tail  --button=OK:0 --center --checkbox="処理終了を確認"
