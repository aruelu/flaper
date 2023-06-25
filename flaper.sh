#!/bin/bash

cd `dirname $0`
DIRBIN=$HOME/.local/myflatpak

while true
do
    GETSEL=`yad --list --title="処理選択" \
            --column="ID" --column="処理内容" \
            --width=600  --height=400 \
            "01" "flatpakでインストール" \
            "02" "flatpakで探してインストール" \
            "03" "flatpakのソフト起動" \
            "04" "flatpakの文字化け改善" \
            "05" "flatpakのソフト更新" \
            "06" "flatpakの全てのソフト更新" \
            "07" "flatpakのソフト削除" \
            "99" "flaperの終了" `
    GETSELCODE=`echo "$GETSEL" | cut -d "|" -f 1 `

    if [ "$GETSELCODE" = "01" ]; then   
         bash `pwd`/flatpak_install.sh $DIRBIN
    elif [ "$GETSELCODE" = "02" ]; then
         bash `pwd`/flatpak_search-install.sh $DIRBIN
    elif [ "$GETSELCODE" = "03" ]; then
         bash `pwd`/run_flatpak.sh $DIRBIN
    elif [ "$GETSELCODE" = "04" ]; then
         bash `pwd`/flatpak_fc-cache.sh $DIRBIN
    elif [ "$GETSELCODE" = "05" ]; then
         bash `pwd`/flatpak_update.sh $DIRBIN
    elif [ "$GETSELCODE" = "06" ]; then
         bash `pwd`/flatpak_allupdate.sh
    elif [ "$GETSELCODE" = "07" ]; then
         bash `pwd`/flatpak_uninstall.sh $DIRBIN
    elif [ "$GETSELCODE" = "99" ]; then
         exit 0
    fi
done
