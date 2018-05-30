# Salmon


mkdir $(date -d "1 day ago" '+%Y-%m-%d')


 find . -daystart -mtime 1 -print


Archive/2018-05-29$ find ../../Grabber -daystart -mtime 1 -print | xargs mv -t .
