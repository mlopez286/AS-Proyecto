#!/bin/bash

# 1. Crear la sesión y guardar información en sesionInfo.txt
info=/data/infoSesion.txt

#ip=http://localhost:8080
# IP del servidor Lightstreamer
#ip="192.168.0.2:8080"
ip="server-ls:8080"
#puerto=":8080
# Meter un pequeño tiempo para que el servidor Lightstreamer se haya creado y configurado correctamente
sleep 5
echo ""
echo "####################################################################"
echo "#                         SESIÓN Y MENSAJES                        #"
echo "####################################################################"
echo ""
echo "Este cliente creará un ID de sesión y se quedará a la escucha de mensajes
del servidor Lightstreamer.Todos los mensajes de la sesión se guardarán en /data/infoSesion.txt"
echo "-------------------------------------------------------------------------"
echo ""

# Crear una sesión utilizando el set de adaptadores "Chat" y volcar el output al fichero sesionInfo.txt que se alojará en un volumen
curl -o $info -v -N -X POST -d "LS_adapter_set=CHAT&LS_cid=mgQkwtwdysogQz2BJ4Ji%20kOj2Bg" $ip/lightstreamer/create_session.txt?LS_protocol=TLCP-2.0.0 
