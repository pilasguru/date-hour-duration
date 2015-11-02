#!/bin/bash
FECHA=$(zenity --calendar --text="Seleccione fecha del evento" --date-format=%Y-%m-%d)
INICIO=$(zenity --entry --text="Indique hora de comienzo, ej: 21:30")
DURACION=$(zenity --entry --text="Indique duración del evento en horas")
FIN=`echo $(date --date "$FECHA $INICIO" +%s) + $(($DURACION*3600)) | bc -l`
zenity --info --text="Evento finaliza el:\n$(date -d@$FIN +%d/%b/%Y' a las '%H:%M)"
exit 0

