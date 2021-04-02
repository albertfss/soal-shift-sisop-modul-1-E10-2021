# soal-shift-sisop-modul-1-E10-2021
Kelompok E-10
- Stefanus Albert Kosim (05111940000096)
- Ahmad Luthfi Hanif (05111940000179)
- Albert Filip Silalahi (05111940000116)

# Soal 1

# Soal 2

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
