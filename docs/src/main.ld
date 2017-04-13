src/main.ld
============

Untuk membuat `ELF executable` kita harus menghubungkan `object files`.

`. = 0x00100000` digunakan untuk menetapkan 1MiB sebagai `address` awal.
mengapa tidak `0x0`?, secara default memang `linker` menetapkanya di `0x0`,
`0x00100000` adalah letak yang konvensional untuk kernel karena banyak `address`
yang cukup spesial dibawah area 1MiB, sebagai contoh video memory (0xb8000).

Selanjutnya
===========
`build.d`

Sebelumnya
==========
`src/kernel/kernel.d`

Sumber referensi
================
  http://os.phil-opp.com/multiboot-kernel.html
