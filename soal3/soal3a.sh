#!/bin/bash

save=0

function isDownloaded()
{
    awk '
        BEGIN {
            cmp[0]="init";
            dl=0;
        }
        /cache/resized {
            dl+=1
            cmp[dl]=$3;
        }
        END {
            if(dl == 1) {
                exit 0
            } 
            else {
                for(i=1; i<dl; i++) {
                    if(cmp[i] == cmp[dl]) {
                        exit 1
                    }
                }
            }
            exit 0
        }
    ' Foto.log
}



for((i=0;i<23;i++));
do
    number=$(($save + 1))
    if [ $number -lt 10 ]
    then
        number="0$number"
    fi

    wget -nv -O Koleksi_$number.jpg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log

    isDownloaded
    check=$?

    if [ $check == 1 ] 
    then
        rm Koleksi_$number
    else
        save=$(($save + 1))
    fi
done