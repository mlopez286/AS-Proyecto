#!/bin/bash

# 1. Crear la sesión y guardar información en infoSesion.txt
aux=/data/infoSesion.txt
#ip=http://localhost:8080

ip="192.168.0.2:8080"
curl -o $aux -v -N -X POST -d "LS_adapter_set=CHAT&LS_cid=mgQkwtwdysogQz2BJ4Ji%20kOj2Bg" $ip/lightstreamer/create_session.txt?LS_protocol=TLCP-2.0.0 
# Conseguir el ID de la sesión recien creada
sesionID=$(cat $aux | head -n 1 | cut -d ',' -f 2)
echo $sesionID > $aux
