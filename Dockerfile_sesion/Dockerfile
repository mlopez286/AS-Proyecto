# Imagen base
FROM ubuntu

# Instalar CURL
RUN apt -qq update && apt -qq -y install curl

#Copiar el script al contenedor
COPY sesion_LS.sh ./sesion_LS.sh
# Ejecutar el script
CMD bash sesion_LS.sh
