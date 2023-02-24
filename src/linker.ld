ENTRY(start)

SECTIONS {

    . = 1M;

    .rodata ALIGN(4K) : {
        KEEP(*(.multiboot_header))
        *(.rodata)
    }

    .text ALIGN(4K) : {
        *(.text)
    }

    .data ALIGN(4K) : {
        *(.data)
    }

    .bss ALIGN(4K) : {
        *(COMMON)
        *(.bss)
    }
}
