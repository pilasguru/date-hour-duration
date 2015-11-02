#!/bin/bash
# Receive:
# $1 - %Y-%m-%d
# $2 - 21:30
# $3 - 4 (horas)

## No funciona en MacOSX

if [ ! "$#" ==  "3" ]; then
	echo "Uso: $0 2015-11-03 09:00 3"
	exit 1
else 
	FECHA=$1
	INICIO=$2
	DURACION=$3
	FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*3600)) | bc -l`
	echo "Evento finaliza el: $(date -d@$FIN +%d/%b/%Y' a las '%H:%M)"
fi
exit 0

