# Imagen base
FROM ubuntu

# Actualizar e instalar CURL
RUN apt -qq update && apt -qq -y install curl

# Copiar el script al contenedor
COPY cliente_LS.sh ./cliente_LS.sh

# Ejecutar el script
CMD bash cliente_LS.sh
