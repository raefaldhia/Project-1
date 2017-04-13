format ELF

section '.multiboot_header'
MULTIBOOT_MAGIC            =    0xE85250D6
MULTIBOOT_ARCHITECTURE     =    0
MULTIBOOT_HEADER_LENGTH    =    (.multiboot_header_end - .multiboot_header_start)
MULTIBOOT_CHECKSUM         =    -(MULTIBOOT_MAGIC + MULTIBOOT_ARCHITECTURE + MULTIBOOT_HEADER_LENGTH)
.multiboot_header_start:
        dd MULTIBOOT_MAGIC
        dd MULTIBOOT_ARCHITECTURE
        dd MULTIBOOT_HEADER_LENGTH
        dd MULTIBOOT_CHECKSUM

        dw 0
        dw 0
        dd 8
.multiboot_header_end:

section '.text'
public main
main:
    extrn kernel
    call kernel

    cli
hang:
    hlt
    jmp hang
