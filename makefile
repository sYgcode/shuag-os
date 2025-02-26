# Assembler
ASM = nasm

SRC_DIR = src
BUILD_DIR = build
# Output files
BOOTLOADER = $(BUILD_DIR)/boot.bin


# Build the bootloader
all: $(BOOTLOADER)

$(BOOTLOADER): $(SRC_DIR)/boot.asm
	$(ASM) -f bin $< -o $@

# Run in QEMU
run: $(BOOTLOADER)
	qemu-system-x86_64 -drive format=raw,file=$(BOOTLOADER)

# Cleanup
clean:
	rm -f $(BOOTLOADER)
