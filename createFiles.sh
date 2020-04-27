#!/bin/bash

trap exit_handler EXIT

exit_handler() { # Config törlése klpépéskor
rm config.txt
echo "Config törölve."
}

echo "$(basename $0) started running with process ID: $$"

# Paraméter ellnnörzés
if [ $# -ne 1 ] ; then
  echo "No parameter directory given. Usage: $(basename $0) dest_dir"
  exit 1
fi

# Config fájl használata
touch config.txt
echo DEST_DIR="$1" >config.txt
. config.txt

if [ ! -d $DEST_DIR ] ; then
  echo  "Directory doesn't exist. Create? Y/N"
  read A
  if [ $A = Y ] | [ $A = y ] ; then
    mkdir $DEST_DIR
  else 
    echo "Failed to create directory. Exiting."
    exit 2
  fi
fi

# Beolvasás
echo -n "Filename with content:  "
read FILE
echo -n "Empty filename: "
read E_FILE

# Ha nem létezik az input file ext 3
if [ ! -f $FILE ] | [ ! -f $E_FILE ] ; then
  echo "Input file error."
  exit 3
fi

# Algoritmus
I=1

mkdir ./$DEST_DIR/content
mkdir ./$DEST_DIR/empty

while [ $I -lt 50 ] ; do
  if [ $(expr $I % 2) -eq 0 ] ; then
    cp $FILE ./$DEST_DIR/content/FILE_$I
  else
    cp $E_FILE ./$DEST_DIR/empty/E_FILE_$I
  fi
  I=$(expr $I + 1)
done 

echo Done creating files.


