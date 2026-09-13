#!/bin/bash
# Build va chay 1 file assembly tren QEMU, in ket qua.   Dung: ./run.sh lab2
set -e
f=${1%.s}                                  # "lab2.s" hoac "lab2" deu duoc

arm-none-eabi-as -mcpu=cortex-m3 -mthumb -g "$f.s" -o "$f.o"
arm-none-eabi-ld -T link.ld "$f.o" -o "$f.elf"

# QEMU chay nen: -S = dung ngay tu dau, -gdb = mo cong 1234 cho gdb noi vao
qemu-system-arm -M lm3s6965evb -cpu cortex-m3 -nographic -kernel "$f.elf" -S -gdb tcp::1234 >/dev/null 2>&1 &
qemu=$!
trap 'kill $qemu 2>/dev/null || true' EXIT # tat QEMU khi script ket thuc
sleep 1

# Moi bien trong .bss (RAM) -> 1 dong "ten = gia tri"
show=()
for v in $(arm-none-eabi-nm "$f.elf" | awk 'tolower($2)=="b" {print $3}'); do
  show+=(-ex "printf \"  $v = %d\n\", *(int*)&$v")
done

gdb-multiarch -q -batch "$f.elf" \
  -ex "target remote :1234" -ex "break stop" -ex "continue" \
  -ex "echo \n--- Thanh ghi ---\n" -ex "info registers r0 r1 r2 r3 r4 r5 r6 r7" \
  -ex "echo \n--- KET QUA (bien trong RAM) ---\n" "${show[@]}" \
  -ex "kill" 2>&1 | grep -v -e '^Kill the program' -e '^\[Inferior'
