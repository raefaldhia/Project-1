src/main.asm
============

`format ELF` digunakan agar output yang dibuat oleh assembler berformat `ELF`

`ELF` adalah Executable and Linkable Format yang di design oleh Unix System
Laboratories. ELF adalah format standar yang digunakan oleh Unix-like system.

Saat ini, kita tidak akan membuat `bootloader`, kita akan memakai bootloader
`multiboot` seperti `GRUB`.

`multiboot` adalah standar yang menyediakan `kernel` agar dapat dieksekusi oleh
`bootloader` yang mengadopsi standar `multiboot`.

Agar `Operating System` yang kita buat dapat dieksekusi oleh `bootloader`
baris pertama dari `Operating System` kita harus terdefinisi `multiboot header`.

Layout dari `multiboot header` dapat dilihat dari tabel di bawah:

|=======|=====|==============|=========|
|Offset |Type | Field Name   |Note     |
|=======|=====|==============|=========|
|0      |u32  |magic         |required |
|4      |u32  |architecture  |required |
|8      |u32  |header_length |required |
|12     |u32  |checksum      |required |
|16-XX  |     |tags          |required |
|=======|=====|==============|=========|

Untuk lebih lengkapnya, bisa dilihat di `docs/multiboot.pdf`.

`magic` digunakan agar `bootloader` dapat mengidentifikasi bahwa
`Operating System` mendukung `multiboot`.

`architecture` digunakan untuk menspesifikasikan `CPU instruction`, diisi 0
untuk 32-bit (protected) mode dari i386. Hal ini mengakibatkan `Operating System`
berada di `Protected Mode`.

Biasanya struktur `tags` memiliki 3 komponen berikut,
|====|======|
|u16 |type  |
|u16 |flags |
|u32 |size  |
|====|======|

setelah mendefinisikan `tags` yang diperlukan, `tags` harus diakhiri dengan
`tags` ber-type 0 dengan size 8. Saat ini kita tidak membutuhkan `tags` sehingga
terlihat hanya `tags` ber type 0.

Selanjutnya
===========
`build.d`

Sebelumnya
==========
`src/kernel/kernel.d`

Sumber referensi
================
  http://os.phil-opp.com/multiboot-kernel.html
  http://wiki.osdev.org/Bare_Bones_with_NASM
  http://wiki.osdev.org/ELF
  http://wiki.osdev.org/Multiboot
