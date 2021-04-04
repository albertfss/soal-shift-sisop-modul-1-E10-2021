# soal-shift-sisop-modul-1-E10-2021
Kelompok E-10
- Stefanus Albert Kosim (05111940000096)
- Ahmad Luthfi Hanif (05111940000179)
- Albert Filip Silalahi (05111940000116)

# Soal 1
Ryujin diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusaahan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

## a.
Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. 

### Penyelesaian
```
ERROR=$(grep "ticky" syslog.log | cut -f 6- -d' ' | grep -E "ERROR")
INFO=$(grep "ticky" syslog.log | cut -f 6- -d' ' | grep -E "INFO")

grep "ticky" syslog.log | cut -f 6- -d' ' | grep -E "ERROR"
echo
grep "ticky" syslog.log | cut -f 6- -d' ' | grep -E "INFO"
echo
```
Menggunakan grep untuk mengambil baris yang terdapat pesan "ticky" lalu di cut dengan parameter f6 untuk mengambil kata ke 6 dan seterusnya dengan delimiter spasi lalu disimpan ke dalam variabel ERROR dan INFO. Dua variabel tersebut berfungsi untuk memudahkan saat memasukkan informasi ke dalam file csv pada bagian d nanti.

## b.
Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

### Penyelesaian
```
grep "ERROR" syslog.log | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr
error_list=$(grep "ERROR" syslog.log | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr)
```
Menggunakan grep untuk mengambil baris yang terdapat "ERROR" lalu di grep lagi dengan regular expression "(?<=ERROR )(.* )(?=\()" untuk mengambil bagian setelah "ERROR" dan sebelum "(" yaitu pesan ERROR dari baris tersebut. Di sort dan menggunakan uniq -c untuk menghitung jumlah kemunculan masing-masing pesan ERROR dan di sort berdasarkan jumlah kemunculan ERROR. Lalu disimpan dalam variabel error_list untuk mempermudah untuk memasukkan informasi ke dalam file csv nanti.

## c.
Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

### Penyelesaian
```
grep "ERROR" syslog.log | grep -Po "(?<=\()(.*)(?=\))" | sort | uniq -c
echo
grep "INFO" syslog.log | grep -Po "(?<=\()(.*)(?=\))" | sort | uniq -c
echo
user_list=$(grep -Po "(?<=\()(.*)(?=\))" syslog.log | sort -u)
```
Menggunakan grep untuk mengambil baris yang terdapat "ERROR" lalu di grep lagi dengan regular expression "(?<=\()(.* )(?=\))" untuk mengambil nama user yang terdapat setelah "(" dan sebelum ")", di sort lalu dengan menggunakan perintah uniq -c agar tidak muncul duplikat nama user yang sama. Pada pengambilan kemunculan user yang mendapat pesan "INFO" sama seperti pengambilan user dengan pesan "ERROR" sebelumnya. Lalu menggunakan grep dengan regular expression "(?<=\()(.* )(?=\))" untuk mengambil nama user dan disimpan ke dalam variabel user_list dan di sort dengan -u agar user dengan nama sama tidak terduplikat untuk mempermudah memasukkan informasi ke dalam csv nanti.

## d.
Menuliskan informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

### Penyelesaian
```
echo "Error,Count" > error_message.csv
echo "$error_list" | while read baris;
do 
	  err=$(echo $baris | cut -d ' ' -f 2-)
	  errCount=$(echo $baris | cut -d ' ' -f 1)
	  echo "$err,$errCount" >> error_message.csv
done
cat error_message.csv
echo
```
Pertama "Error,Count" dimasukkan ke dalam file error_message.csv sebagai header dari file. Lalu membaca setiap baris yang terdapat dalam variabel error_list dengan menggunakan loop. Didalam loop err berfungsi untuk menyimpan jenis error dengan menggunakan cut dengan delimiter spasi dan parameter -f 2- untuk mengambil pesan errornya saja. Pada errCount digunakan cut dengan delimiter spasi dan dan parameter -f1 untuk megambil jumlah kemunculan errornya saja. Lalu err dan errCount dimasukkan dengan format "$err,$errCount" ke dalam file error_message.csv. Semua dilakukan secara berurutan.

## e.
Menuliskan informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

### Penyelesaian
```
echo "username,INFO,ERROR" > user_statistic.csv
for i in $user_list
do 
	  errorCount=$(echo "$ERROR" | grep -E "(ERROR).*(\($i\))" | wc -l)
	  infoCount=$(echo "$INFO" | grep -E "(INFO).*(\($i\))" | wc -l)
	  echo "$i,$infoCount,$errorCount" >> user_statistic.csv
done
cat user_statistic.csv
echo
```
Pertama "username,INFO,ERROR" dimasukkan ke dalam file user_statistic.csv sebagai header dari file. lalu dilakukan loop untuk setiap nama user yang terdapat didalam user_list.
variabel ERROR ditampilkan lalu di grep untuk diambil ERROR yang terdapat nama user secara berurutan dengan loop lalu dihitung kemunculannya dan disimpan didalam variabel errorCount. infoCount menggunakan cara yang sama dengan errorCount. Lalu informasi dimasukkan secara berurutan dengan format "$i,$infoCount,$errorCount" ke dalam user_statistic.csv.

## Kesulitan

- Terdapat kesulitan saat membuat Regular Expression untuk mengambil jenis pesan ERROR dan username.
- Sebelum direvisi, pada nomor 1a data yang diambil tidak tersaring yaitu jenis log hingga usernamenya.
- Sebelum direvisi, pada nomor 1c tidak menghitung jumlah kemunculan ERROR/INFO tiap user.

# Soal 2
Steven, Manis, dan Clemong meminta bantuan untuk mencari beberapa kesimpulan dari data penjualan "Laporan-TokoShiShop.tsv"

## a.
Menampilkan **Row ID** dan **profit percentage terbesar** (jika hasil profit percentage terbesar lebih dari1, maka ROW ID yang paling besar akan muncul). 
Rumus mendapatkan profit percentage dituliskan sebagai berikut
Profit Percentage = (Profit/Cost Price)x100
```
export LC_ALL=C
```
Bagian ini digunakan untuk lokalisasi bahasa, dimana data pada file yang mengandung titik akan dibaca sebagai koma (desimal).
```
awk '
BEGIN{FS="\t"}
```
Kita menggunakan awk untuk dapat membaca data dari file. Begin digunakan untuk memulai pembacaan code. FS \t merupakan perintah untuk melakukan pembacaan data dengan menggunakan tab (per kolom) sebagai pemisahnya.
```
{
	ProfitPersentase=$21/($18-$21)*100;
```
sesuai dengan rumus Profit Persentase yang telah diberikan pada soal. Kita mengambil data Profit dari kolom ke 21 dan sales dari kolom ke 18.
```
	if(max<=ProfitPersentase)
	{
		max=ProfitPersentase;
		RowID=$1;
	}
}
```
Max sebelumnya tidak ada sehingga bernilai nol, saat max<=ProfitPersentase, maka nilai max adalah ProfitPersentase dan RowID akan diinput

```
END
{
	printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%% \n", RowID, max);
}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Disini kita akan mencetak sesuai dengan permintaan soal, dan hasilnya disimpan di file hasil.txt

## b.
Clemong membutuhkan daftar **nama customer pada transaksi tahun 2017 di Albuquerque.**


## c.
Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment customer** dan **jumlah transaksinya yang paling sedikit.**


## d. 
Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut.**


# Soal 3

Kuuhaku adalah kolektor foto digital sekaligus pemalas dan pemalu (tidak ingin ada yang melihat koleksi fotonya) sehingga dia membuat :

## a.

 Script untuk **mengunduh** 23 gambar dari "https://loremflickr.com/320/240/kitten" lalu **mengubah** nama gambar menjadi "Koleksi_XX" dengan XX adalah urutan foto dimulai dari 01, 02, 03, ..., 23. Karena dia tak mau ada foto duplikat, dia ingin menghapus duplikatnya namun **tidak memgizinkan ada urutan yang hilang atau terputus**. Log dari unduhan tersebut kemudian **disimpan** kedalam file bernama "Foto.log"

 ### Penyelesaian

 Untuk menyelesaikan permasalahan ini, dapat dilihat garis besar permasalahnnya adalah **downloading**, **renaming**, **no-duplicate**, **creating log**
 - Untuk mengunduh 23 foto tersebut, digunakan command <code>wget -nv -O Koleksi_$number.jpg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log</code>. -nv adalah untuk mengeluarkan basic log dan basic error dari proses unduhan tersebut. <code>tee -a Foto.log</code> adalah untuk meyimpan outputnya (bukan hasil unduhan) ke file Foto.log
 - Untuk renaming file, terlebih dahulu dicek duplikat dari file yang baru saja diunduh menggunakan awk dan Foto.log. Karena hasil dari lognya adalah <code>2021-04-03 00:00:05 URL:https://loremflickr.com/cache/resized/65535_51081679358_dba1fafb78_320_240_nofilter.jpg [15892/15892] -> "Koleksi_01.jpg" [1]</code>, maka dengan awk, diambil kata ke-3 yang merupakan URL dari file yang diunduh kemudian dicompare dengan baris yang lain, jika ditemukan maka file akan dihapus, tetapi counternya tidak bertambah.
  
## b.

Crontab agar scriptnya jalan pada hari-hari tertentu yaitu mulai dari tanggal 1 dalam 7 hari sekali (1,8,15,...) dan mulai dari tangal 2 setiap 4 hari sekali (2,6,10,...) di jam 20:00. Hasil unduhannya kemudian disimpan ke dalam folder dengan format "DD-MM-YYYY"

### Penyelesaian

Untuk permasalahan ini, scriptnya hampir sama dengan 3a, namun ada tambahan membuat folder dengan format DD-MM-YYYY. Untuk crontab yang digunakan adalah <code>0 20 1-31/7,2-31/4 * * cd /path/ ** bash soal3b.sh</code>

## c.

Script untuk mengunduh gambar tambahan, yaitu kelinci di link https://loremflickr.com/320/240/bunny, dengan proses unduh yang bergantian sesuai tanggal, kemudian gambar beserta log dari unduhan tersebut disimpan ke folder <code>Kucing_DD-MM-YYYY</code> untuk kucing dan <code>Kelinci_DD-MM-YYYY</code> untuk kelinci

### Penyelesaian
  
Dengan menggunakan konsep yang sama dengan script 3b untuk unduh dan foldernya, yang perlu ditambahkan adalah bagian kelinci. Adapun hal yang perlu diperhatikan di permasalahan ini adalah mengunduh secara **bergantian**, sehingga perlu dilakukan pengecekan. Pengecekan tersebut ialah :

- Menggunakan awk untuk menghitung berapa banyak masing-masing folder kucing dan kelinci.
- Jika banyaknya sama, maka akan mengunduh gambar kucing, sebaliknya jika banyaknya berbeda maka akan mengunduh kelinci. (Menggunakan konsep jumlah folder karena permintaan soal sudah wajib mengunduh sehari sekali secara bergantian)

## d.

Script untuk **memindahkan** semua folder ke zip dengan nama "Koleksi.zip" dengan nama dan password adalah tanggal pada hari itu dengan format tanggal "MMDDYYYY" (04022021).

### Penyelesaian

Di permasalahan ke-4 ini, hanya perlu menjalankan command `zip` dan membuat password, lalu kemudian folder yang telah di-zip tadi dihapus sehingga hanya meninggalkan file zip. 

`password=$(date +"%m%d%Y")
temp=$(ls | grep -E "_|-|log|jpg")
zip -r -P "$password" Koleksi.zip $temp
rm -r *-*
rm -r *.jpg
rm Foto.log`

## e. 

Crontab untuk membuat koleksinya **ter-zip** pada **weekday** di jam 7 pagi hingga 6 sore, selain itu dia ingin koleksinya **ter-unzip**

### Penyelesaian

Untuk membuat file ter-zip dan ter-unzip, maka akan digunakan 2 crontab

1. Pada jam 7 pagi di weekday `0 7 * * 1-5` akan menjalankan `soal3d.sh`
2. Pada jam 6 sore di weekday `0 18 * * 1-5` akan menjalankan command berikut `unzip -P ``date +\%m\%d\%Y`` Koleksi.zip && rm Koleksi.zip`

## Kesulitan

- Terdapat kesulitan dalam mengerjakan 3c, yaitu ketika mencari jenis foto yang terakhir diunduh
- Terdapat kekeliruan dalam mengerjakan 3d, yaitu ketika memilih folder untuk dizip
