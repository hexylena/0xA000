all: 0xA000-Regular.ttf            \
		 0xA000-Bold.ttf               \
		 0xA000-Semibold.ttf           \
		 0xA000-Mono-Regular.ttf       \
		 0xA000-Mono-Bold.ttf          \
		 0xA000-Mono-Semibold.ttf      \
	   0xA000-Pixelated-Regular.ttf  \
	   0xA000-Pixelated-Mono.ttf     \
	   0xA000-Boxes-Regular.ttf      \
		 0xA000-Boxes-Mono.ttf         \
	   0xA000-Dots-Regular.ttf       \
		 0xA000-Dots-Mono.ttf          \
	   0xA000-Monochrome-Regular.ttf \
	   0xA000-Monochrome-Mono.ttf    \
		 0xA000-Edit-Mono.ttf          \
		 0xA000-Pen-Regular.ttf        \
		 0xA000-Pen-Mono.ttf           \
		 \
		 Glyphs.html                   \
		 Tech.html                     \
		 index.html

CFLAGS += -O2 -g

tilegen: tilegen.c
	gcc $< -o $@ `pkg-config --cflags --libs gegl`

0xA000-Regular.ttf:       slimmed.pal
0xA000-Mono-Regular.ttf:  slimmed.pal
0xA000-Pen-Regular.ttf:   squiggly.pal
0xA000-Pen-Mono.ttf:      squiggly.pal

%.pal: %.png tilegen
	./tilegen $< > $@
%.ttf: %.asc glyphs-*.asc
	./bake_ttf.sh `echo $< | sed s/\.asc//`

%.html: %.content head.html
	cat head.html neck.html $< end.html > $@

# this also relies on all ufo dirs existing.
# it has to be manually invoked
Glyphs.content: Glyphs.content.sh UnicodeData.txt
	./$< > $@

# not including such a huge file in the repo..
UnicodeData.txt:
	wget ftp://ftp.unicode.org/Public/UNIDATA/UnicodeData.txt

clean: 
	rm -rf *.ttf *.ufo
	rm -rf *.pal
	rm -rf tilegen 
