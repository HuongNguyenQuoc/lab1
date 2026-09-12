@ =====================================================
@ LAB 1 - BAI 1: Tinh tong cac so <= N
@ S = 1 + 2 + 3 + ... + N
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
N:      .word   10

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align  2
ketQua: .space  4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR     R0, =N
    LDR     R0, [R0]

    MOV     R1, #0
    MOV     R2, #1

loop:
    CMP     R2, R0
    BHI     done
    ADD     R1, R1, R2
    ADD     R2, R2, #1
    B       loop

done:
    LDR     R3, =ketQua
    STR     R1, [R3]

stop:
    B       stop

    .end
