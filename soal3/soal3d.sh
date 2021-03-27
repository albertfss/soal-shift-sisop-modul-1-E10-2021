#!/bin/bash

password=$(date +"%m%d%Y")
echo $password
zip -P $password -r Koleksi.zip K*_*
rm -r K*_*