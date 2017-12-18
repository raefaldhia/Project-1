#!/usr/bin/env rdmd

import core.sys.posix.stdlib;
import core.stdc.string;
import std.getopt;
import std.process;
import std.stdio;

int main(string[] args)
{
    void writeln(string str)
    {
        std.stdio.writeln("build.d: " ~ str);
    }

    bool quiet = false;
    void Quiet(string option)
    {
        quiet = true;
    }

    bool verbose = false;
    void Verbose(string option)
    {
        verbose = true;
    }

    string exec(string cmd)
    {
        if (!quiet)
        {
            writeln(cmd);
        }
        auto result = std.process.executeShell(cmd);
        if (verbose && result.output.length != 0)
        {
            writeln(result.output);
        }
        if (result.status != 0)
        {
            writeln("`"~ cmd ~ "` returned non-zero value, build failed.");
            exit(result.status);
        }
        return result.output;
    }

    getopt(args, "q|quiet", &Quiet,
                 "v|verbose", &Verbose);

    exec("ldc -m64 -c -defaultlib=false -debuglib=false -code-model=kernel -w -of=bin/obj/src/kernel/kernel.o src/kernel/kernel.d");
    exec("fasm src/main.asm bin/obj/src/main.o");
    
    exec("ld -m elf_x86_64 -nostdlib -nodefaultlibs -T src/main.ld -o bin/os/os.bin bin/obj/src/main.o  bin/obj/src/kernel/kernel.o");
    exec("grub-mkrescue -o bin/os.iso bin/os");

    writeln("build success.");
    return 0;
}
