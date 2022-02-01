1000 REM J.KLASEK J AT KLASEK.AT
1010 REM 2012-05-08
1100 DIMC,I,V,P,IM,IP,IA
1105 REM XOR
1106 DEF FN XR(X)=(C OR X)-(C AND X)
1108 REM INTEGER CORRECTION (16-BIT SIGNED)
1109 DEF FN IC(X)=X+(X>IP)*IA
1110 HE$="0123456789ABCDEF"
1120 IM=-32768:IP=32767:IA=65536
1200 GOTO 10000
1900 REM calculate with signed
1901 REM integers, e.g. for 3 bits:
1911 REM -4   -3   -2   -1   0   1   2   3
1912 REM 100 101  110  111  000 001 010 011
1913 REM < 0 -> HSB set
1914 REM < -4 -> overflow, correct with +8
1915 REM   -3+-3=-6 (1010) -> 2 (010)
1916 REM > 3 -> overflow, correct with -8
1917 REM   3+3=6 (110) -> -2 (010)
1920 REM
1921 REM analog for 16 bit in range -32768 to +32767
1998 END
1999 REM CRC16 subroutine
2000 REM polynom $1021, to 16-bit integer range:
2005 P=1*4096+2*16+1: P=FN IC(P)
2006 C=0
2010 PRINT "POLYNOM:"P;:D=P:GOSUB 3000:PRINT " $"H$
2011 PRINT "START-CRC:"C;:D=C:GOSUB 3000:PRINT " $"H$
2050 FOR A=STOS+N-1
2060 :V=FN IC(PEEK(A)*256):REM get memory, to high byte
2080 :REM C=(CORV)-(CANDV)
2085 :C=FN XR(V)
2095 :REM PRINT A;PEEK(A);V," CRC=";C
2100 FORB=1TO8
2110 : IF C<0 THEN 2300
2115 :  REM only shift left
2120 :  C=C+C:IF C>IP THEN C=C-IA
2130 : GOTO 2400
2290 :  REM shift left
2300 :  C=C+C:IF C<IM THEN C=C+IA
2305 :  REM divide by polynom ...
2310 :  REM C=(CORP)-(CANDP)
2320 :  C=FN XR(P)
2400 : NEXT
2500 NEXT
2900 RETURN
2999 REM DEC->HEX subroutine
3000 H$=""
3005 IF D<0 THEN D=D+IA
3010 FORI=DTO0STEP0
3020 H=INT(I/16):H$=MID$(HE$,I-H*16+1,1)+H$
3030 I=H:NEXT
3035 REM H$=RIGHT$("000"+H$,4);
3040 RETURN
3045 REM PRINT "D2H:"D;I;H;" ";H$
9999 REM
10000 REM S=START, N=COUNT
10010 S=49152: REM memory where to write the data ...
10015 DATA "@ZYXWVUTSRQPONMLKJIHGFEDBCA": REM X-MODEM CRC=$B199
10016 DATA "@A@N @A@RBITRARY @S@TRING": REM X-MODEM CRC=$DDFC
10029 DATA ""
10030 GOTO 10080
10040 GOSUB 11000: REM RETURNS N
10050 T=TI:GOSUB 2000:PRINT "ELAPSED TIME:"TI-T
10060 D=C:GOSUB 3000
10070 PRINT "CRC16=";C;" $"H$:PRINT
10080 READ D$: IF D$<>"" THEN 10040
10998 END
10999 REM move data from string to memory
11000 N=LEN(D$):PRINT "DATA: "D$
11010 AC=32: REM start with ASCII lowercase
11015 DO$="":M=S
11020 FOR I=1TON
11030 A=ASC(MID$(D$,I,1))AND127
11040 IF A=64 THEN AC=32-AC:GOTO11100
11050 DO$=DO$+CHR$(A-128*(AC=0))
11060 A=(A-AC*(A>64ANDA<91))
11090 POKE M,A:M=M+1
11100 NEXT
11110 PRINT:PRINT DO$;:N=LEN(DO$):PRINT ", N:"N
11120 RETURN
