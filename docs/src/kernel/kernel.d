src/kernel/kernel.d
===================

`LDC_no_moduleinfo` digunakan untuk mematikan generasi metadata untuk
mendaftarkan module ke druntime. saat ini kita tidak akan memakai druntime
karena kita akan membuat sebuah `Operating System`.

Karena kita berada didalam `Protected Mode`, kita dapat mengakses secara langsung
video memory. `address` dari video memory adalah 0xB8000 (atau 0xB0000).

Selanjutnya
===========
`src/main.ld`

Sebelumnya
==========
`src/main.asm`

Sumber referensi
================
  https://wiki.dlang.org/LDC-specific_language_changes#LDC_no_moduleinfo
  http://wiki.osdev.org/Printing_To_Screen
