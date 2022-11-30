#!/bin/bash

# Variables
#-------------------------
aux=/data/infoSesion.txt
# IP del servidor Lightstreamer
ip="192.168.0.2:8080"

# Hace un poco de tiempo para que sesion-ls pueda crear la sesión y almacenar el ID
sleep 10 
# Conseguir el ID de sesión almacenado en /data/infoSesion.txt
sesionID=$(cat $aux | head -n 1 | cut -d ',' -f 2) 

# Suscribirse al item "chat_room"
curl -v -N -X POST -d "LS_op=add&LS_subId=1&LS_data_adapter=CHAT_ROOM&LS_group=chat_room&LS_schema=timestamp message&LS_mode=DISTINCT&LS_session=$sesionID&LS_reqId=1" $ip/lightstreamer/control.txt?LS_protocol=TLCP-2.0.0


# Publicar 100 mensajes en el item "chat_room"(timestamp, message). Se enviarán 100 mensajes con la forma "Mensaje: X" siendo X un número aleatorio.
# Esperará 1s entre mensajes.
lista=$(seq {1,100})
mensaje=""
echo ""
echo "####################################################################"
echo "#                         ENVÍO DE MENSAJES                        #"
echo "####################################################################"

echo "Se enviarán 100 mensajes al servidor Lightstreamer..."
echo ""
for i in $lista
do
	
	mensaje=$(echo "Mensaje: $RANDOM")
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "	ENVIANDO MENSAJE Nº $i... > $mensaje"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
 
 	curl -v -N -X POST -d "LS_session=$sesionID&LS_message=CHAT|$mensaje&LS_outcome=false&LS_reqId=1" $ip/lightstreamer/msg.txt?LS_protocol=TLCP-2.0.0
	# Espera 1 segundo entre mensaje y mensaje
	sleep 1 

done

# Prints informativos
echo "¡ACABADO: SE HAN ENVIADO LOS 100 MENSAJES!"

echo "####################################################################"
echo "#                         LOG DE LA SESIÓN                         #"
echo "####################################################################"
echo " "
echo "El otro cliente (contenedor sesion-ls) no imprime contenido en esta terminal "
echo "porque está redireccionando el output a un fichero."
echo "Este fichero se llama infoSesion.txt y se encuentra almacenado en un volumen."
echo ""
echo "  > Su contenido se imprimirá a continuación:"
echo ""
sleep 15

echo ""
echo "CONEXIÓN OK | ID SESIÓN | LÍMITE SOLICITUD | T MANTENIMIENTO | ENLACE DE CONTROL"
echo "--------------------------------------------------------------------------------"
# Imprime el log de la sesión que ha guardado el otro cliente.
cat $aux
