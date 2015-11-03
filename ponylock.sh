#!/bin/sh
while [[ `xkb-switch` != *"us"* ]]
do
    xkb-switch -n
done
SCREEN_RES="1440x900"
convert ponies_splash.png -resize $SCREEN_RES^ -gravity center -extent $SCREEN_RES /tmp/pony_pic.png
i3lock -e -i /tmp/pony_pic.png
DERPIBOORU_URL="https://derpiboo.ru/search/index?q=background,+score.gt:50,+safe&random_image=y"
IMG_URL=".gif"
while [[ $IMG_URL ==  *"gif" ]]
do
    IMG_URL=`curl -Ls -w %{url_effective} $DERPIBOORU_URL | grep -Po '\[img\]\K[^\[]*full[^\[]*' | sed 's/full/large/g'`
done
wget -O /tmp/pony_pic.img $IMG_URL
convert /tmp/pony_pic.img -resize $SCREEN_RES^ -gravity center -extent $SCREEN_RES /tmp/pony_pic.png
killall i3lock
i3lock -e -i /tmp/pony_pic.png
rm -f /tmp/pony_pic*
