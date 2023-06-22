#!/bin/bash

GETSTRFILE="/tmp/search-install-str_"$$".tmp"
TMPFILE="/tmp/search-install-tmp_"$$".tmp"
APPLIST="/tmp/search-install-applist_"$$".list"
SELAPP="/tmp/search-install-selapp_"$$".list"
LOGFILE="/tmp/serch-install_"$$".log"

DIRBIN=$1

. ./flaper_function

yad --entry --width=300 --height=100 \
        --title="flatpakで検索するソフトを入力して下さい" \
         > $GETSTRFILE

GETSTR=`cat $GETSTRFILE`
echo "GETSTR="$GETSTR
if [ "$GETSTR" = "" ]
then
     yad --error --text="入力されていません"
    exit 1
fi

flatpak search "$GETSTR" | grep "$GETSTR" | \
    awk -F "\t" '{ print $1"\t" $6"," $3 }' | \
    sort | uniq  > $TMPFILE

cat $TMPFILE | grep -v "Plugin" | awk -F "\t" '{ print $1"\n"$2 }'> $APPLIST
if [ `cat $APPLIST | wc -l ` = 0 ]
then
    yad --error  --title="実行エラー" --text="ソフトがありません"
    exit 2
else
    cat $APPLIST | yad --list  \
                          --title="インストールするソフトを選択して下さい" \
                          --width=600 --height=400 \
                          --column="ソフト名" --column="appID"  > $SELAPP
fi

if [ `cat $SELAPP |  wc -l` = 0 ]
then
    yad --error  --title="実行エラー" --text="ソフトが選択されていません"
    exit 3
else
    APPNAME=`cat $SELAPP | cut -f 1 -d "|"`
    GETREMOTES=`cat $SELAPP | cut -f 2 -d "|" | cut -f 1 -d ","`
    GETAPPID=`cat $SELAPP | cut -f 2 -d "|" | cut -f 2 -d ","`

    cat $SELAPP
    echo $APPNAME
    echo $GETREMOTES
    echo $GETAPPID
    echo $GETDISPLAY


    flatpakinstall "$LOGFILE" "$DIRBIN" "$APPNAME" "$GETREMOTES" "$GETAPPID" 
fi
