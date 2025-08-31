/*
 * A bootrom image for use in simulations where memory can be
 * pre loaded by elf-loaders. Clears registers and jumps to 0x100.
 */

#define OR1K_RESET_VECTOR 0x100

bootrom_init:
	l.movhi	r0, 0x0
	l.movhi	r3, hi(OR1K_RESET_VECTOR)
	l.ori	r3, r3, lo(OR1K_RESET_VECTOR)
	l.jr	r3
	 l.nop
