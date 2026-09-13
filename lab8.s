@ =====================================================
@ LAB 1 - BAI 8: Tim boi chung nho nhat cua 2 so
@ BCNN(a, b) = (a / UCLN(a, b)) * b
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
soA:        .word   12
soB:        .word   18

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align  2
bcnn:       .space  4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR R4, =soA
    LDR R4, [R4]

    LDR R5, =soB
    LDR R5, [R5]

    MOV R0, R4
    MOV R1, R5
    BL tinhUCLN

    UDIV R6, R4, R0
    MUL R6, R6, R5

    LDR R7, =bcnn
    STR R6, [R7]

stop:
    B stop

@ ---- Chuong trinh con: tinh UCLN ----
@ Vao : R0 = a, R1 = b
@ Ra  : R0 = UCLN(a, b)
@ Pha : R1, R2, R3
    .thumb_func
tinhUCLN:
ucln_lap:
    CMP R1, #0
    BEQ ucln_xong

    UDIV R2, R0, R1
    MLS R3, R2, R1, R0
    MOV R0, R1
    MOV R1, R3
    B ucln_lap

ucln_xong:
    BX LR

    .end
    