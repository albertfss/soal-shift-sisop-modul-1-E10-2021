#!/bin/bash

#2A
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{
	ProfitPersentase=$21/($18-$21)*100

	#mencari profit terbesar dan id terbawah
	if(max<=ProfitPersentase)
	{
		max=ProfitPersentase
		RowID=$1
	}
}

END
{
	printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%% \n", RowID, max)
} ' /home/albert/sisopE10/Laporan-TokoShisop.tsv >> hasil.txt

#2b
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{
	OrderID=$2
	City=$10
	CustomerName=$7
	if (OrderID~"2017" && City == "Albuquerque")
	{arrcustomer[CustomerName]++}
}

END 
{
	print "\nDaftar nama customer di Albuequerque pada 		tahun 2017 antara lain:\n"
	for (CustomerName in arrcustomer)
	{print CustomerName}
}' /home/albert/sisopE10/Laporan-TokoShiSop.tsv >> hasil.txt

#2c
export LC_ALL=C
awk '
BEGIN {FS="\t"}
{

	if (NR>1)
	{ 
		segment[$8]++
	}
}

END 
{
	MinSal=10000
	for (temp  in segment)
	{
	 	#temp merupakan isiarray
		if (MinSal>segment[temp])
		{
			MinSal=segment[temp]
			hasil=temp
		}
	}
	printf("\nTipe segment customer yang penjualannya paling sedikit adalah %s dengan segment %.3f\n", hasil, MinSal)
} ' /home/albert/sisopE10/Laporan-TokoShiSop.tsv >> hasil.txt

#2d
export LC_ALL=C
awk '
BEGIN {FS="\t"}
{
	if (NR>1)
	{ 
	region [$13]+=profit[$21]
	}
}


END 
{
	MinProfit=10000
	for(wilayah in region) 
	{
		if (MinProfit > region[wilayah])
		{
			MinProfit = region[wilayah]
			MinProfit = wilayah
		}
  	}
	printf ("Wilayah bagian (region) yang memiliki total keuntungan (profit)  yang paling sedikit adalah %s dengan total keuntungan %s" wilayah,region[wilayah]")
} ' /home/albert/sisopE10/Laporan-TokoShiSop.tsv >> hasil.txt
