## De0 Nano OpenRISC SOC

A [fusesoc](https://github.com/olofk/fusesoc) core which provides an OpenRISC
SOC for the [De0 Nano](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=593)
FPGA development board.  This is capable of booting linux.

To build and program this to your FPGA board use:

```
fusesoc library add de0_nano https://github.com/olofk/de0_nano.git

# Build the bitstream
fusesoc run de0_nano
# Program the bitstream to your board over usb-blaster
fusesoc run --run de0_nano --pgm quartus
```

To run the board simulation we could use:

```
fusesoc run --target sim de0_nano --jtag_vpi_enable
```

See the [OpenRISC de0 nano tutorial](https://openrisc.io/tutorials/de0_nano/) for more details.

## Parameters

The following parameters are available to be set during simulation.

 `bootrom_file` - initail contents of the boot ROM (used with `fusesoc run --target sim`). See `/sw/` directory for an example.
 `spi_flash_file` - initail contents of the SPI Flash (used with `fusesoc run --target sim`). See `/bench/` directory for an example.

## Bootloader

The de0 nano system is set up by default to start executing at address
`0xf0000000` where the boot ROM is located. The contents of the bootloader memory
can be set by changing the top-level parameter `bootrom_file` to a different
file. Two different bootloaders are shipped with the de0_nano files.

### SPI Flash bootloader

File: `/sw/spi_uimage_loader.vh`

The spi_loader program starts executing from internal Boot ROM. This reads out a
binary image stored in the on-board SPI Flash and writes it to SDRAM. For
simulations, the contents of the SPI Flash can be set with the `spi_flash_file`
parameter

When the program is done loading to RAM, spi_loader will jump to address `0x100`
where it expects the first instruction of the program that was copied from the
SPI Flash

### Clear R3 and jump to 0x100

File: `/sw/clear_r3_and_jump_to_0x100.vh`

The boot ROM will clear registers `r0` and `r3` and then proceeed to start executing
a program from address `0x100`. This bootloader is intended for simulation
purposes where a program can be preloaded to RAM with the
`--elf-load=/path/to/elf-file` parameter, as well as on target HW where the RAM is
initialized with a debugger
