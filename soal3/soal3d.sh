#!/bin/bash

password=$(date +"%m%d%Y")
temp=$(ls | grep -E "_|-|log|jpg")
zip -r -P "$password" Koleksi.zip $temp
rm -r *-*
rm -r *.jpg
rm Foto.log