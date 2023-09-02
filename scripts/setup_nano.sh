#! /bin/sh

OUTFILE=$1/etc/skel/.nanorc
echo "set autoindent" > $OUTFILE
echo "set linenumbers" >> $OUTFILE
# echo "set morespace" >> $OUTFILE
echo "set mouse" >> $OUTFILE
echo "set noconvert" >> $OUTFILE
echo "set nohelp" >> $OUTFILE
echo "set nonewlines" >> $OUTFILE
echo "set nowrap" >> $OUTFILE
echo "set softwrap" >> $OUTFILE
echo "set tabsize 4" >> $OUTFILE
echo "set tabstospaces" >> $OUTFILE
# echo "set smooth" >> $OUTFILE

cp $OUTFILE $1/root