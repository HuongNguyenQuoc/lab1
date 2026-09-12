TARGET = lab1

all: $(TARGET).elf

$(TARGET).o: $(TARGET).s
	arm-none-eabi-as -mcpu=cortex-m3 -mthumb -g $< -o $@

$(TARGET).elf: $(TARGET).o link.ld
	arm-none-eabi-ld -T link.ld $(TARGET).o -o $@

clean:
	rm -f *.o *.elf

.PHONY: all clean
