@ =====================================================
@ LAB 1 - BAI 7: Tim uoc chung lon nhat cua 2 so
@ Thuat toan Euclid: UCLN(a, b) = UCLN(b, a mod b)
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
soA:        .word   48
soB:        .word   18

@ ---- Du lieu ra (RAM, ghi duoc) ----
    .section .bss
    .align  2
ucln:       .space  4

@ ---- Ma lenh ----
    .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    LDR R0, =soA
    LDR R0, [R0]

    LDR R1, =soB
    LDR R1, [R1]

loop:
    CMP R1, #0
    BEQ done
    
    @ ---- UDIV: Unsigned DIVide chia nguyên: phần thập phân bị vứt đi, không làm tròn. ----
    UDIV R2, R0, R1
    @ ---- MLS: MuLtiply and Subtract R3 = R0 − (R2 × R1)
    MLS R3, R2, R1, R0

    MOV R0, R1
    MOV R1, R3
    B loop

done:
    LDR R4, =ucln
    STR R0, [R4]

stop:
    B       stop

    .end
    