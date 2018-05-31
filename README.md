# Salmon


mkdir $(date -d "1 day ago" '+%Y-%m-%d')

find . -daystart -mtime 1 -print

cd Archive/$(date -d "1 day ago" '+%Y-%m-%d')
Archive/2018-05-29$ find ../../Grabber -daystart -mtime 1 -print | xargs mv -t .

# Kind of working. 

ssh jarleven@laksen.local "mkdir Archive/$(date -d "1 day ago" '+%Y-%m-%d')"
ssh jarleven@laksen.local "find ./Grabber -daystart -mtime 1 -print | xargs mv -t ./Archive/$(date -d "1 day ago" '+%Y-%m-%d')"

rsync -r -a -v -e ssh jarleven@192.168.1.166:/home/jarleven/Archive/ /home/tredea/MayBak/

# -r : Recursive
# -a : Archive mode
# -v : Verbose
# -e : Specify shell
