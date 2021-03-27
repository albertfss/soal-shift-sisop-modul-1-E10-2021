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

lastDl=$(ls -d *_* | cut -d'_' -f2 | cut -c '10,9,8,7,5,4,2,1' | sort -n)
echo "$lastDl"

for VAR in $lastDl
do
    i=0
    echo "$VAR x $i"
    i=$(($i + 1))
done
