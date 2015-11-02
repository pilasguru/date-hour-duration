#!/bin/bash
# Receive:
# $1 - %Y-%m-%d
# $2 - 21:30
# $3 - 4 (horas)

## No funciona en MacOSX
## Requiere testing Linux

FECHA=$1
INICIO=$2
DURACION=$3
echo $FECHA
echo $INICIO
echo $DURACION
FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*3600)) | bc -l`
echo $FIN
echo "Evento finaliza el: $(date -d@$FIN +%d/%b/%Y' a las '%H:%M)"
exit 0

