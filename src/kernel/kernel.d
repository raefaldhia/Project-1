module kernel;

version (LDC)
{
    pragma(LDC_no_moduleinfo);
}
else
{
    static assert(0, "fix this");
}

@nogc extern(C) void kernel()
{
	const uint COLUMNS = 80;
	const uint LINES = 25;

	ubyte* vidmem = cast(ubyte*)0xB8000;

	for (int i = 0; i < COLUMNS * LINES * 2; i++) {
			*(vidmem + i) = 0;
	}

	*(vidmem + (0) * 2) = 'D' & 0xFF; //Prints the letter D
    *(vidmem + (1) * 2) = 'A' & 0xFF; //Prints the letter A
    *(vidmem + (2) * 2) = 'M' & 0xFF; //Prints the letter M
    *(vidmem + (3) * 2) = 'N' & 0xFF; //Prints the letter N
    *(vidmem + (4) * 2) = '!' & 0xFF; //Prints the letter !

    *(vidmem + (0) * 2 + 1) = 0x09;
    *(vidmem + (1) * 2 + 1) = 0x09;
    *(vidmem + (2) * 2 + 1) = 0x09;
    *(vidmem + (3) * 2 + 1) = 0x09;
    *(vidmem + (4) * 2 + 1) = 0x09;

    while (true)
    {

    }
}
