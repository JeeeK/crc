# Makefile crc16 BASIC
# for Linux
# 2022, 2023 J.E. Klasek j klasek at


# petlc: Lower case tool (only unquoted parts)
# lc: to lower case (string constants lost case, maybe wrong!)


all: crc16.prg crc16.dragon.cas


### Emulate

# CBM-BASIC CLI-Emulator
c64.cli: crc16.bas
	cbmbasic crc16.bas

c64: crc16.prg
	x64 crc16.prg

# Xroar-Emulator
dragon: crc16.dragon.cas
	xroar -tape-ao-rate 48000 -nodos -keymap de -kbd-translate -default-machine dragon32 -ram 64 -run crc16.dragon.cas "$@"


### Source to Binary ...

crc16.prg: crc16.bas
	perl -pe '$$_=lc($$_)' crc16.bas | petcat -text -w2 -o crc16.prg 

crc16.dragon.cas: crc16.dragon.bas
	bas2cas $< $@ -v

