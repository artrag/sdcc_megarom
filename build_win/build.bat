@echo off

set CCFLAGS=-mz80 --opt-code-speed --std-c11 --no-std-crt0 --nostdlib --max-allocs-per-node 100000 
set RAM_ADDR=0xc000
set BANK0_SIZE=0x3000
set BANKn_SIZE=0x4000
set BANK0_ADDR=0x04100
set BANK2_ADDR=0x28000
set BANK4_ADDR=0x48000
set BANK6_ADDR=0x68000
set BANK8_ADDR=0x88000
set BANK10_ADDR=0x0a8000
set BANK12_ADDR=0x0c8000
set BANK14_ADDR=0x0e8000
set BANK16_ADDR=0x108000
set BANK18_ADDR=0x128000
set BANK20_ADDR=0x148000
set BANK22_ADDR=0x168000
set BANK24_ADDR=0x188000
set BANK26_ADDR=0x1a8000
set BANK28_ADDR=0x1c8000
set BANK30_ADDR=0x1e8000
set BANK32_ADDR=0x208000
set BANK34_ADDR=0x228000
set BANK36_ADDR=0x248000
set BANK38_ADDR=0x266000
set BANK40_ADDR=0x288000
set BANK42_ADDR=0x2a8000
set BANK44_ADDR=0x2c8000
set BANK46_ADDR=0x2e8000
set BANK48_ADDR=0x308000
set BANK50_ADDR=0x328000
set BANK52_ADDR=0x348000
set BANK54_ADDR=0x368000
set BANK56_ADDR=0x388000
set BANK58_ADDR=0x3a8000
set BANK60_ADDR=0x3e8000
set BANK62_ADDR=0x3c8000

set BANKS_ADDR=-Wl-b_BANK0=%BANK0_ADDR% -Wl-b_BANK2=%BANK2_ADDR% -Wl-b_BANK4=%BANK4_ADDR% -Wl-b_BANK6=%BANK6_ADDR% -Wl-b_BANK8=%BANK8_ADDR% -Wl-b_BANK10=%BANK10_ADDR% -Wl-b_BANK12=%BANK12_ADDR% -Wl-b_BANK14=%BANK14_ADDR% -Wl-b_BANK16=%BANK16_ADDR% -Wl-b_BANK18=%BANK18_ADDR% -Wl-b_BANK20=%BANK20_ADDR% -Wl-b_BANK22=%BANK22_ADDR% -Wl-b_BANK24=%BANK24_ADDR% -Wl-b_BANK26=%BANK26_ADDR% -Wl-b_BANK28=%BANK28_ADDR% -Wl-b_BANK30=%BANK30_ADDR% -Wl-b_BANK32=%BANK32_ADDR% -Wl-b_BANK34=%BANK34_ADDR% -Wl-b_BANK36=%BANK36_ADDR% -Wl-b_BANK38=%BANK38_ADDR% -Wl-b_BANK40=%BANK40_ADDR% -Wl-b_BANK42=%BANK42_ADDR% -Wl-b_BANK44=%BANK44_ADDR% -Wl-b_BANK46=%BANK46_ADDR% -Wl-b_BANK48=%BANK48_ADDR% -Wl-b_BANK50=%BANK50_ADDR% -Wl-b_BANK52=%BANK52_ADDR% -Wl-b_BANK54=%BANK54_ADDR% -Wl-b_BANK56=%BANK56_ADDR% -Wl-b_BANK58=%BANK58_ADDR% -Wl-b_BANK60=%BANK60_ADDR% -Wl-b_BANK62=%BANK62_ADDR%


md build
cd build
sdasz80 -o megarom.rel ..\src\megarom.s
sdcc %CCFLAGS% --codeseg BANK0 --code-size %BANK0_SIZE% -c ..\src\main.c
sdcc %CCFLAGS% --codeseg BANK2 --code-size %BANKn_SIZE% -c ..\src\test.c
sdcc %CCFLAGS% --codeseg BANK4 --code-size %BANKn_SIZE% -c ..\src\test_rev.c
sdcc %CCFLAGS% -o main.ihx --data-loc %RAM_ADDR% %BANKS_ADDR% megarom.rel main.rel test.rel test_rev.rel
..\build_win\makerom.exe main.ihx main.rom
cd ..
