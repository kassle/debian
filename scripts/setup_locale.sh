#! /bin/sh

OUTFILE=$1/etc/default/locale
echo 'LANG="C.UTF-8"' > $OUTFILE
echo 'LANGUAGE="C.UTF-8"' >> $OUTFILE
echo 'LC_ALL="C.UTF-8"' >> $OUTFILE
