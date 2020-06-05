#!/usr/bin/env bash
set -e
set -u

file=$(realpath "$1")
filepath=$(dirname "$file")
find_frame="${filepath}/find.jpg"
desc_date=$(sed -e 's/.*\(20[1-2][0-9]\.[0-1][0-9]\.[0-3][0-9]\).*/\1/' -e 's@\.@-@g' <<< "$file")
yt_date=$(sed -e 's/.*\(20[1-2][0-9]\.[0-1][0-9]\.[0-3][0-9]\).*/\1/' -e 's@\.@-@g' <<< "$file")
yt_time=$(sed -e 's@.* - \([0-9.]*\)\..*@\1@' -e 's@\.@\:@g' <<< "$file")
yt_datetime="${yt_date}T${yt_time%:*}.${yt_time##*:}Z"
tmpf=$(mktemp -d)
cd "$tmpf"
# trap 'rm -rf "$tmpf"' EXIT
mkdir "${filepath}/{enc,done,failed}/"

ffmpeg -sseof -1 -i "$file" -update 1 -q:v 1 results.png 2> /dev/null
# vw
convert results.png -rotate 90 -crop '494x25+311+320!' title.png
convert results.png -rotate 90 -crop '480x85+550+750!' score.png

# hh
# convert results.png -rotate 90 -crop '635x26+223+375!' title.png
# convert results.png -rotate 90 -crop '385x78+405+1255!' score.png

score=$(tesseract score.png - -c 'tessedit_char_whitelist=0123456789' 2> /dev/null | perl -ne "chomp and print")
title_en=$(tesseract -l eng title.png - 2> /dev/null | perl -ne "chomp and print")
title_jp=$(tesseract -l jpn title.png - 2> /dev/null | perl -ne "chomp and print")

echo "$score"
echo "$title_en"
echo "$title_jp"

title="${title_jp// }"

if [[ -z "${title// }" ]];then
    title="${title_en// }"
fi

if [[ -z "${title// }" ]];then
    printf "%s\n" "\\\\wsl$\\Arch${tmpf//\//\\}"
    echo -ne '\aenter title: '
    read -e -r title
fi

start_time=$(ffmpeg -copyts -i "$file" -i "$find_frame" -filter_complex "[0]extractplanes=y[v];[1]extractplanes=y[i];[v][i]blend=difference,blackframe=0,metadata=select:key=lavfi.blackframe.pblack:value=98:function=greater,trim=duration=0.0001,metadata=print:file=-" -an -v 0 -vsync 0 -f null - | head -1 | sed 's/.*pts_time\:\(.*\)\.[0-9]\+/\1/')
if [[ -z $start_time ]];then
    mv "$file" "${filepath}/failed/"
    echo "failed finding start_time on ${title}, moving ${file} to ${filepath}/failed"
    exit 1
fi

ffmpeg -noaccurate_seek -i "$file" -ss "$start_time" -c copy -metadata:s:v:0 rotate=270 "${filepath}/enc/${title} ${score} ${desc_date}.mp4" && mv "$file" "${filepath}/done/"

# ~/youtube-upload/venv/bin/python3 ~/youtube-upload/bin/youtube-upload \
#     --title="$title" \
#     --description="$score
# $desc_date
# $title_en
# $title_jp" \
#     --recording-date="$yt_datetime" \
#     --playlist="sdvx" \
#     --privacy unlisted \
#     --category Gaming \
#     out.mp4
