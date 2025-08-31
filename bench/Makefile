# A make file for de0 nano SPI Images

BOOTROM_ADDR ?= 0x80000
RESET_VECTOR ?= 0x100
# Default loads binaries straight to reset vector,
# override to 0x0 for already offset elf binaries.
LOAD_ADDRESS ?= 0x100
IMAGE ?= spi_image
IMAGE_NAME ?= $(IMAGE)

all: $(IMAGE).vh

%.vh: %.ub
	or1k-elf-objcopy --change-addresses $(BOOTROM_ADDR) -I binary -O verilog $< $@

%.bin: %.elf
	or1k-elf-objcopy -O binary $< $@

# The spi image is a u-boot image and can be up to 8MB, the size of the
# EPCS64.
%.ub: %.bin
	mkimage \
	-A or1k \
	-C none \
	-T standalone \
	-a $(LOAD_ADDRESS) \
	-e $(RESET_VECTOR) \
	-n '$@' \
	-d $< \
	$@

%.elf: %.S
	or1k-elf-gcc -nostdlib $< -o $@

clean:
	rm -f $(IMAGE).vh
