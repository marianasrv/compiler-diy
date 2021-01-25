.SUFFIXES: .$(EXT) .asm .obj .exe
LANG=diy
EXT=diy
LIB=lib
RUN=run
ARCH=
AS=nasm -felf32
#ARCH=-DpfARM
#AS=as
CC=gcc
CFLAGS=-g -DYYDEBUG $(ARCH)

$(LANG): $(LANG).y $(LANG).l $(LANG).brg
	make -C $(LIB)
	make -C $(RUN)
	byacc -dv $(LANG).y
	flex -l $(LANG).l
	pburg -T $(LANG).brg
	$(LINK.c) -o $(LANG) -I$(LIB) lex.yy.c y.tab.c yyselect.c -L$(LIB) -lutil

clean::
	make -C $(LIB) clean
	make -C $(RUN) clean
	rm -f *.o $(LANG) lex.yy.c y.tab.c y.tab.h y.output yyselect.c outfp *.asm *~ *.obj *.exe a.out
