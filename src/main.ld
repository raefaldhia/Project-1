OUTPUT_FORMAT(elf64-x86-64)

ENTRY(main)

SECTIONS {
    . = 1M;

    .text :
    {
        *(.multiboot)
        *(.text)
    }

    .rodata :
    {
        *(.rodata)
    }

    .bss :
    {
        *(.bss)
    }
}
