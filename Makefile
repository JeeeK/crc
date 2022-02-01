

# petlc: Lower case tool (only unquoted parts)
# lc: to lower case (string constants lost case, maybe wrong!)

all: crc16.prg

run:
	 cbmbasic crc16.bas

crc16.prg: crc16.bas
	perl -pe '$$_=lc($$_)' crc16.bas | petcat -text -w2 -o crc16.prg 

