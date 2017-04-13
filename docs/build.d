build.d
=======

`build.d` adalah script yang kita gunakan untuk membangun `Operating System`.

Langkah pertama adalah membuat 'src/main.asm' dan 'src/kernel/kernel.asm' menjadi
`object file`, kemudian dibuat menjadi suatu ELF executable menggunakan
GNU Linker.

Setelah itu langkah terakhir adalah membuat bootable ISO dengan GRUB.

`Operating System` dapat di coba menggunakan qemu atau virtualbox.
```
qemu-system-x86_64 bin/os.img
```
