@ =====================================================
@ LAB 1 - BAI 5: Tinh x mu n
@ kq = x * x * ... * x   (n lan)
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
n:          .word   10

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align  2
luyThua:    .space  4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR     R0, =x
    LDR     R0, [R0]

    LDR     R1, =n
    LDR     R1, [R1]

    MOV     R2, #1

loop:
    CMP     R1, #0
    BEQ     done

    MUL     R2, R2, R0
    SUB     R1, R1, #1
    B       loop

done:
    LDR     R3, =luyThua
    STR     R2, [R3]

stop:
    B       stop

    .end
