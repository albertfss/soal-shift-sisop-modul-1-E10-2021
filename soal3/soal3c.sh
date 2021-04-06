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

function mvNeko() 
{
    today=$(date +"%d-%m-%Y") 
    mkdir Kucing_$today
    mv *.jpg Kucing_$today
    mv Foto.log Kucing_$today
}

function mvUsagi()
{
    today=$(date +"%d-%m-%Y") 
    mkdir Kelinci_$today
    mv *.jpg Kelinci_$today
    mv Foto.log Kelinci_$today
}

dir="/home/yanzkosim/SISOP/Praktikum/Modul1/soal-shift-sisop-modul-1-E10-2021/soal3"
folder="`ls $dir`"

awk '
    BEGIN {
        countNeko=0
        countUsagi=0
    }
    /Kucing/ {
        split($1, separator, "_");
        split(separator[2], tanggal, "-");
        countNeko++
    }
    /Kelinci/ {
        split($1, separator, "_");
        split(separator[2], tanggal, "-");
        countUsagi++
    }
    END {
        if ( countNeko == countUsagi ) {
            exit 1
        } else {
            exit 2
        }
    }
' <<< $folder

animal=$?
today=$(date +%d)
if [ $animal == 1 ] 
then
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
    mvNeko
else
    for((i=0;i<23;i++));
    do
        number=$(($save + 1))
        if [ $number -lt 10 ]
        then
            number="0$number"
        fi

        wget -nv -O Koleksi_$number.jpg https://loremflickr.com/320/240/bunny 2>&1 | tee -a Foto.log

        isDownloaded
        check=$?

        if [ $check == 1 ] 
        then
            rm Koleksi_$number
        else
            save=$(($save + 1))
        fi
    done
    mvUsagi
fi