#!/bin/bash

# 2. Suscribirse al item chat_room
aux=/data/infoSesion.txt
ip="192.168.0.2:8080"

sesionID=$(cat $aux | head -n 1 | cut -d ',' -f 2) 
curl -v -N -X POST -d "LS_op=add&LS_subId=1&LS_data_adapter=CHAT_ROOM&LS_group=chat_room&LS_schema=timestamp message&LS_mode=DISTINCT&LS_session=$sesionID&LS_reqId=1" $ip/lightstreamer/control.txt?LS_protocol=TLCP-2.0.0


# 3. Publicar mensajes en los campos timestamp y message del item chat_room

lista=$(seq {1,100})
mensaje=""
echo "Se enviarán 100 mensajes..."

for i in $lista
do
	mensaje=$(echo "Mensaje: $RANDOM")
        curl -v -N -X POST -d "LS_session=$sesionID&LS_message=CHAT|$mensaje&LS_outcome=false&LS_reqId=1" $ip/lightstreamer/msg.txt?LS_protocol=TLCP-2.0.0
	sleep 1 

done

echo "¡ACABADO: SE HAN ENVIADO LOS 100 MENSAJES!"

