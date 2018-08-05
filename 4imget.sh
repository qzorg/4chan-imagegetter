#!/bin/bash


show_help() {

    cat << EOF

Usage: [-hk] [-d DIRECTORY] [-t THREAD]
Download images from a 4chan thread.

    -h display this help
    -d select the name for the directory
    -t select the thread to download from
    -k keep thumbnails
EOF
}

directory="threads"
OPTIND=1
keep_thumbs=0


while getopts ":d:t:h:k" opt; do
    case $opt in
        d)
            directory=$OPTARG
            ;;
        t)
            thread=$OPTARG
            ;;
        k)
            keep_thumbs=1
            ;;
        \?) show_help
            exit 0
            ;;
        :)
            echo "Option -$OPTARG requires an argument">&2
            ;;
    esac
done
if [ "$thread" ]
then
    echo "putting files from $thread into $directory"
    wget -P $directory -nd -r -l 1 -H -D is2.4chan.org -A png,gif,jpg,jpeg,webm $thread
    if [ $keep_thumbs -eq 1 ]
    then
        exit 0
    else
        rm $directory/*s.*
        exit 0
    fi
    
else
   echo "Please pass the -t argument with a valid thread URL"
   exit 1
fi


#wget -P threads -nd -r -l 1 -H -D i.4cdn.org -A png,gif,jpg,jpeg,webm $1
