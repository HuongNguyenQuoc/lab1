@ =====================================================
@ LAB 1 - BAI 6: Tinh tong S = 1 + x^2 + x^3 + ... + x^n
@ =====================================================
    .syntax unified
    .cpu    cortex-m3
    .thumb

@ ---- Bang vector ngat ----
    .section .vectors, "a"
    .word   0x20001000
    .word   Reset_Handler

@ ---- Du lieu vao (FLASH, chi doc) ----
    .section .rodata
    .align  2
x:          .word   2
n:          .word   4

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align  2
tongS:    .space  4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR R0, =x
    LDR R0, [R0]

    LDR R1, =n
    LDR R1, [R1]

    MOV R2, #2
    MOV R3, R0
    MOV R4, #1

loop:
    CMP R2, R1
    BGT done

    MUL R3, R3, R0
    ADD R4, R4, R3
    ADD R2, R2, #1
    B loop

done:
    LDR R5, =tongS
    STR R4, [R5]

stop:
    B stop

    .end
