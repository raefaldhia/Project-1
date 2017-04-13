ENTRY(main)
OUTPUT_FORMAT(elf32-i386)

SECTIONS {
    . = 0x00100000;

    .text :
    {
		*(.multiboot_header)
        *(.text)
    }
}
