format ELF64

use32

section '.multiboot'
MULTIBOOT_MAGIC            equ    0xE85250D6
MULTIBOOT_ARCHITECTURE     equ    0
MULTIBOOT_HEADER_LENGTH    equ    (.multiboot_header_end - .multiboot_header_start)
MULTIBOOT_CHECKSUM         equ    -(MULTIBOOT_MAGIC + MULTIBOOT_ARCHITECTURE + MULTIBOOT_HEADER_LENGTH)
.multiboot_header_start:
    dd       MULTIBOOT_MAGIC
    dd       MULTIBOOT_ARCHITECTURE
    dd       MULTIBOOT_HEADER_LENGTH
    dd       MULTIBOOT_CHECKSUM

    dw       0
    dw       0
    dd       8
.multiboot_header_end:

section '.rodata'
GDT64:
.Null = $ - GDT64
    dq       0
.Code = $ - GDT64
    dq       0x20980000000000                                                         ;(1<<43) | (1<<44) | (1<<47) | (1<<53)
.Data = $ - GDT64
    dq       0x00900000000000
.Pointer:
    dw       $ - GDT64 - 1
    dq       GDT64

section '.bss' align 4096
align 4096
PML4E:
    rb 0x1000
PDPE:
    rb       0x1000
p2_table:
    rb       0x1000
.stack_bottom:
    rb       0x4000
stack_top:

section '.text'
public main
main:
    mov esp, stack_top                                                          ; setup stack
    cmp eax, 0x36d76289                                                         ; check whether multiboot2 is supported
    jne      .hang                                                              ; multiboot2 not supported
.1:                                                                             ; check whether CPUID is supported
    pushfd
    pop      eax
    mov      ecx, eax
    xor      eax, 0x200000
    push     eax
    popfd
    pushfd
    pop      eax
    cmp      eax, ecx
    je       .hang
.2:                                                                             ; check whether long mode supported
    mov     eax, 0x80000000
    cpuid
    cmp     eax, 0x80000001
    jb      .hang
    mov     eax, 0x80000001
    cpuid
    test    edx, 0x20000000
    jz     .hang
.3:                                                                             ; check whether 1-Gbyte paging supported
;   mov     eax, 0x80000001
;   cpuid
;   test    edx, 0x4000000
;   jz      .hang
.4:                                                                             ; enable physical-address extensions
    mov     eax, cr4
    or      eax, 0x20
    mov     cr4, eax
.5:                                                                             ; setup 1Gb Paging
    mov     eax, PDPE
    or      eax, 0x3
    mov     [PML4E], eax
    mov dword [PDPE], 0x83
.6:                                                                             ; load cr3
    mov     eax, PML4E
    mov     cr3, eax
.7:                                                                             ; enable long mode
    mov     ecx, 0xC0000080
    rdmsr
    or      eax, 0x100
    wrmsr
.8:                                                                             ; enable paging
    mov     eax, cr0
    or      eax, 0x80000000
    mov     cr0, eax
.9:
    lgdt    [GDT64.Pointer]
    jmp     GDT64.Code:main64
.hang:
    hlt
    jmp     .hang




use64

section '.text'
    main64:
    mov     ax, 0
    mov     ss, ax
    mov     ds, ax
    mov     es, ax
    mov     fs, ax
    mov     gs, ax
    extrn kernel
    call kernel
    hlt
