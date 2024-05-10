#!/bin/bash

top_label(){
    python3 ./bin/print_top_labels.py --n-top=$3 --labels $2 --net-out $1
}

read_dir(){
    for file in `ls -a $1`
    do
        if [ -d $1"/"$file ]
        then
            if [[ $file != '.' && $file != '..' ]]
            then
                read_dir $1"/"$file
            fi
        else
            if [[ "${file##*.}" = 'out' ]]
            then
                echo $1"/"$file
                top_label $1"/"$file $2 $3
            fi
        fi
    done
}

read_dir $1 $2 $3
