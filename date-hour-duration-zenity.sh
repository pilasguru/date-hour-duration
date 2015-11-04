#!/bin/bash
# Requiere zenity https://help.gnome.org/users/zenity/stable/

# zenity existe
whereis zenity >/dev/null
if [ "$?" != "0" ]; then 
        echo "Require zenity https://help.gnome.org/users/zenity/stable/"
        exit 1
fi 

# date version
(date --version | grep GNU) >/dev/null 2>&1
if [ "$?" != "0" ]; then 
	echo "Require GNU date"
	exit 1 
fi

FECHA=$(zenity --calendar --text="Seleccione fecha del evento" --date-format=%Y-%m-%d)

INICIO=$(zenity --entry --text="Indique hora de comienzo, ej: 21:30")
until [[ $INICIO =~ ([01][0-9]|2[0-3]):[0-5][0-9] ]]; do
	zenity --error --text="ERROR en la hora de inicio, debe ser HH:MM (24hs)"
	INICIO=$(zenity --entry --text="Indique hora de comienzo, ej: 21:30")
done

DURA=$(zenity --entry --text="Indique duración del evento en horas(3h) o minutos (3m)")
until [[ $DURA =~ ^[0-9]+[mh]$ ]]; do
        zenity --error --text="ERROR en las horas(h) o minutos(m) de duracion del evento, ej: 3m / 3h"
	DURA=$(zenity --entry --text="Indique duración del evento en horas(3h) o minutos (3m)")
done
DURACION=$(echo $DURA | sed s/[mh]//)
if [[ $(echo $DURA | rev | cut -c 1) =~ h ]]; then
        # h
        FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*3600)) | bc -l`
else
        # m
        FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*60)) | bc -l`
fi

zenity --info --text="Evento finaliza el:\n$(date -d@$FIN +%d/%b/%Y' a las '%H:%M)"
exit 0

