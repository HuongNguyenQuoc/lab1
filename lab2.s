@ =====================================================
@ LAB 1 - BAI 2: Tinh tong cac so CHAN va cac so LE <= N
@ Vi du N=10:  chan = 2+4+6+8+10 = 30 ;  le = 1+3+5+7+9 = 25
@ =====================================================
    .syntax unified
    .cpu cortex-m3
    .thumb

@ ---- Bang vector ngat ----
    .section .vectors, "a"
    .word 0x20001000
    .word Reset_Handler

@ ---- Du lieu vao (FLASH, chi doc) ----
    .section .rodata
    .align 2
N: .word 10

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align 2
tongChan: .space 4
tongLe: .space 4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR R0, =N
    LDR R0, [R0]

    MOV R1, #0
    MOV R2, #0
    MOV R3, #1

loop:
    CMP R3, R0
    BHI done

    TST R3, #1
    BEQ even

odd:
    ADD R2, R2, R3
    B tiep

even:
    ADD R1, R1, R3

tiep:
    ADD R3, R3, #1
    B loop

done:
    LDR R4, =tongChan
    STR R1, [R4]

    LDR R4, =tongLe
    STR R2, [R4]

stop:
    B stop

    .end
    