#!/bin/bash

main(){
    dockerContainers=$(docker ps --format {{.ID}})
    getConatiners dockerContainers 
    echo "
Containers ID:$ids
Are you sure to stop all of this containers? y/N"
    read option
    
    selectOption
    
}

selectOption(){
    case $option in
        y | Y)
            command="docker stop $ids"
            echo "Stoping containers..."
            $command
        ;;
        n | N | "")
            echo "Ok. bye bye"
        ;;
    esac
}

getConatiners(){
    containers=($dockerContainers)
    LENGTH=${#containers[@]}
    ids=""
    if (( $to < 0 || $from < 0 || $to >= $LENGTH || $from >= $LENGTH )); then
        echo "Invalid data"
        exit 0
    fi

    if (( $to == 0 )); then
        to=$LENGTH
    fi

    for ((index=$from; index<$to; index++))
    do
        ids+=" ${containers[index]}"
    done
}

from=0
to=0
while getopts t:f: OPTION; do
    case "$OPTION" in
        t)
            to=$OPTARG
        ;;
        f)
            from=$OPTARG
        ;;
        ?)
            echo "Invalid option, try with
                f       from: number
                t       to: number"
            exit 1
        ;;
    esac
done
main from to