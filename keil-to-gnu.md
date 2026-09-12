# Quy đổi chỉ dẫn: Keil armasm (giáo trình) -> GNU as (arm-none-eabi-as)

Nguồn: Bảng 3.1 (tr.69) và Bảng 3.2 (tr.70) của giáo trình.

## Khai báo dữ liệu

| Kiểu       | Sách (Keil)              | Dùng ở đây (GNU)        |
|------------|--------------------------|-------------------------|
| byte       | `DCB 0x12`               | `.byte 0x12`            |
| half-word  | `DCW 0x1234`             | `.hword 0x1234`         |
| word       | `DCD 0x12345678`         | `.word 0x12345678`      |
| double     | `DCQ 0x...`              | `.quad 0x...`           |
| xâu        | `DCB "Hello", 0`         | `.asciz "Hello"`        |
| xâu ko \0  | `DCB "Hello"`            | `.ascii "Hello"`        |
| chừa chỗ   | `SPACE 128`              | `.space 128`            |
| điền giá trị| `FILL 16, 0xFF, 1`      | `.fill 16, 1, 0xFF`     |

Chú ý thứ tự tham số `FILL` / `.fill` bị ĐẢO:
  Keil: FILL <số_byte>, <giá_trị>, <kích_thước>
  GNU:  .fill <số_lần>, <kích_thước>, <giá_trị>

## Chỉ dẫn tổ chức chương trình

| Sách (Keil)                          | Dùng ở đây (GNU)              |
|--------------------------------------|-------------------------------|
| `AREA RESET, DATA, READONLY`         | `.section .vectors, "a"`      |
| `AREA MyData, DATA, READWRITE`       | `.section .data`              |
| `AREA MyData, DATA, NOINIT`          | `.section .bss`               |
| `AREA MyCode, CODE, READONLY`        | `.section .text` (hoặc `.text`)|
| `ALIGN` / `ALIGN 4`                  | `.align 2`  (GNU: luỹ thừa 2!)|
| `ENTRY`                              | (bỏ — dùng ENTRY() trong link.ld)|
| `END`                                | `.end`                        |
| `EXPORT ten`                         | `.global ten`                 |
| `IMPORT ten`                         | `.extern ten`                 |
| `ten EQU 5`                          | `.equ ten, 5`                 |
| `THUMB`                              | `.thumb`                      |
| `nhan PROC` ... `ENDP`               | `.thumb_func` + `nhan:`       |
| `LTORG`                              | `.pool` / `.ltorg`            |

CẢNH BÁO `ALIGN`: Keil `ALIGN 8` = căn theo 8 byte.
GNU `.align 3` = căn theo 2^3 = 8 byte. Số mũ, không phải số byte.

## Cú pháp câu lệnh

| Điểm                | Sách (Keil)          | Dùng ở đây (GNU)       |
|---------------------|----------------------|------------------------|
| Chú thích           | `; chú thích`        | `@ chú thích` hoặc `//`|
| Hằng hex            | `&1234` hoặc `0x1234`| chỉ `0x1234`           |
| Hằng nhị phân       | `2_0111`             | `0b0111`               |
| Nhãn                | ở cột 1, không dấu   | có dấu hai chấm `nhan:`|
| Giá trị tức thời    | `#12`                | `#12` (giống nhau)     |

Bản thân MÃ LỆNH (MOV, LDR, STR, ADD, CMP, B, BL, PUSH, POP, LDM, STM...)
và toán hạng là GIỐNG HỆT NHAU. Không phải đổi gì.

## Bảng vector: sách viết tay, ở đây link.ld lo

Sách (tr.241):
    AREA RESET, DATA, READONLY
    EXPORT __Vectors
    __Vectors DCD 0x20001000
              DCD Reset_Handler

Ở đây:
    .section .vectors, "a"
    .word 0x20001000
    .word Reset_Handler

rồi link.ld có `KEEP(*(.vectors))` đặt section này ở địa chỉ 0x0.
