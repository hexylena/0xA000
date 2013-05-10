#!/bin/sh

echo "<h1><a href='Tech.html'>0xA000</a></h1><h2>Glyph Gallery</h2>"
echo "<div class='glyphs'>"

for a in `ls *.ufo/glyphs -1 | sort | uniq | sed s/\.glif//`; do
  line=`grep "^$a"";" UnicodeData.txt`
  description=`echo $line|cut -f 2 -d ';'`
  if [ -n "$description" ]; then
    echo "
    <div class='glyph'>
      <div class='label'>
        <span class='reference'>&#x$a;</span>
        <span class='unicode'> $a </span>
        <span class='name'>$description</span>
      </div>
      <span class='rendering-Mono'>&#x$a;</span>
      <span class='rendering-Regular'>&#x$a;</span>
      <span class='rendering-Pixelated-Regular'>&#x$a;</span>
      <span class='rendering-Dots-Regular'>&#x$a;</span>
      <span class='rendering-Reference'>&#x$a;</span>
    </div>"
  fi
done

echo "</div>"
