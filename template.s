@ ==========================================================
@ Khung chương trình hợp ngữ ARM Cortex-M3 (cú pháp GNU as)
@ Tương ứng cấu trúc Hình 4.1 trong giáo trình
@ Dịch: arm-none-eabi-as -mcpu=cortex-m3 -mthumb -g
@ ==========================================================
    .syntax unified
    .cpu    cortex-m3
    .thumb

@ ---- Hằng số: sách dùng  soN EQU 9 ----
    .equ    soN, 9

@ ---- AREA RESET, DATA, READONLY ----
    .section .vectors, "a"
    .word   0x20001000          @ giá trị khởi tạo con trỏ ngăn xếp (SP)
    .word   Reset_Handler       @ địa chỉ chương trình khởi động

@ ---- AREA MyData, DATA, READWRITE ----
    .section .data
    .align  2                   @ = ALIGN 4 của Keil (2^2 = 4 byte)
ketQua:
    .word   0                   @ Keil: ketQua DCD 0

@ ---- AREA MyData2, DATA, NOINIT ----
    .section .bss
    .align  2
bienTam:
    .space  16                  @ Keil: bienTam SPACE 16

@ ---- AREA MyCode, CODE, READONLY ----
    .text
    .global Reset_Handler
    .thumb_func                 @ thay cho  Reset_Handler PROC
Reset_Handler:

    @ ------- code của bạn bắt đầu ở đây -------
    LDR     R0, =soN            @ nạp hằng số
    MOV     R1, #0

    @ ------- lưu kết quả ra bộ nhớ -------
    LDR     R2, =ketQua         @ lấy địa chỉ
    STR     R1, [R2]            @ ghi giá trị

stop:
    B       stop                @ vòng lặp vô hạn = kết thúc chương trình
                                @ (thay cho SWI &11 của sách)

    .end
