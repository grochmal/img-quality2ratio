#!/bin/sh

CACHE=~/cache

raw_properties () {
  echo filename width height format compression alpha size quality depth >> $2
  find $CACHE -type f -name "$1" |
  #head -n 12 |
  while read x; do
    if [[ -f $x ]]; then
      #echo "process $x" >&2
      identify -format "%f %w %h %m %C %A %b %Q %q" $x >>$2
    fi
  done
}

raw_properties '*-jpg' raw-jpg.dat
raw_properties '*-png' raw-png.dat

# removing a property value
# convert
# /home/grochmal/cache/d0/d05a09f78eb068a3142bd59adb1e72188c6bc16b-8952-350-350-png
# +set Copyright -quality 05 png05.png

# otptipng tries all setups of -quality lf (and more) for a png.  That's better
# than anything DIY.
# Nevertheless -quality lf means the same as:
#              -define png:compression-level=l
#              -define png:compression-filter=f
# optipng also uses -define png:compression-strategy=s

