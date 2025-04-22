IMAGE_DIR="${HOME}/Pictures/wallpaper"

if [ $# -eq 0 ]; then
    RESULT=`ls ${IMAGE_DIR} | rofi -dmenu -i -p 'Select Wallpaper'`
    if [ -z "${RESULT}" ]; then
        exit 1
    fi
    RESULT="${IMAGE_DIR}/${RESULT}"
else
    RESULT="${IMAGE_DIR}/${1}"
fi
echo ${RESULT}
feh --bg-fill "${RESULT}"
