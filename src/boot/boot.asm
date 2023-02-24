MBOOT_ALIGN equ 1 << 0
MBOOT_MEMINFO equ 1 << 1
MBOOT_FLAG equ MBOOT_ALIGN | MBOOT_MEMINFO
MBOOT_MAGIC equ 0x1BADB002
MBOOT_CHECKSUM equ -(MBOOT_MAGIC + MBOOT_FLAG)

[SECTION .multiboot_header]
align 4
dd MBOOT_MAGIC
dd MBOOT_FLAG
dd MBOOT_CHECKSUM

[SECTION .bss]
align 16
stack_bottom:
resb 0x4000
stack_top:

[bits 32]

[SECTION .text]

[EXTERN kernel_main]

[GLOBAL start]
start:
    mov esp, stack_top

    call kernel_main

    cli
    hlt
    jmp $
