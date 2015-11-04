#!/bin/bash
# Recibe:
# $1 - 2015-11-02
# $2 - 20:51
# $3 - 4 (horas/minutos)

## Solo para GNU-date
## No funciona en MacOSX con BSD-date

if [ ! "$#" ==  "3" ]; then
	echo "Requiere recibir tres parametros"
	echo "Uso: $0 2015-11-03 09:00 3h"
	echo "     $0 "'$(date +%F\ %H:%M) 3m'
	exit 1
else 
	# date version
	(date --version | grep GNU) >/dev/null 2>&1
	if [ "$?" != "0" ]; then 
		echo "Require GNU date"
		exit 1 
	fi
	if [[ $1 =~ [0-9]{4}-(0[1-9]|1[0-2])-([0-2][1-9]|3[01]) ]]; then 
		FECHA=$1
	else
		echo "ERROR en la fecha de inicio, debe ser AAAA-MM-DD"
		exit 2
	fi

	if [[ $2 =~ ([01][0-9]|2[0-3]):[0-5][0-9] ]]; then
		INICIO=$2
	else
		echo "ERROR en la hora de inicio, debe ser HH:MM (24hs)"
		exit 2
	fi
	if [[ $3 =~ ^[0-9]+[mh]$ ]]; then
		DURACION=$(echo $3 | sed s/[mh]//)
	else
		echo "ERROR en las horas(h) o minutos(m) de duracion del evento, ej: 3m / 3h"
		exit 2
	fi
	if [[ $(echo $3 | rev | cut -c 1) =~ h ]]; then
		# h
		FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*3600)) | bc -l`
	else
		# m
		FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*60)) | bc -l`
	fi
	echo "Evento finaliza el: $(date -d@$FIN +%d/%b/%Y' a las '%H:%M)"
fi
exit 0


