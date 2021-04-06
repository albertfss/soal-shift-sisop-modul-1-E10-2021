#!/bin/bash

#2A
export LC_ALL-C

#fungsi untuk membaca input file
max=0
awk'

#iterasi
BEGIN{FS="\t\"}
ProfitPersentase=($21/($18-$21))*100

#mencari profit terbesar dan id terbawah
if(max<=ProfitPersentase)
{
	max=ProfitPersentase
	RowID=$$1
}

END
{
	printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d %\n", RowID, max)
} ' /home/albert/Downloads/Laporan-TokoShisop.tsv >> hasil.txt
