#!/bin/bash

# Verifica la configuración del Host
if [ -z "$SERVER_HOST" ] && [ -z "$SERVER_USER" ]; 
then
    echo "The SERVER_HOST or SERVER_USER variable is not defined in the sustem environment!" >&2
    exit 1000
fi

# Verifica si la variable no está definida
if [ -z "$DATABASE_PASSWORD" ] && [ -z "$DATABASE_USERNAME" ] && [ -z "$DATABASE_NAME" ]; 
then
    echo "The DATABASE USERNAME, DATABASE_NAME, or DATABASE_PASSWORD variable is not defined in the system environment!" >&2
    exit 1000
fi

DIRECTORY="/home/$SERVER_USER/platform-training"

# Verifica si el directorio existe
if [ -d "$DIRECTORY" ]; 
then
    rm -rf "$DIRECTORY"/*
    echo "El contenido del directorio '$DIRECTORY' ha sido eliminado."
else
    mkdir -p "$DIRECTORY"
    echo "El directorio '$DIRECTORY' se ha creado."
fi

# Verifica si la red ya existe
if ! sudo docker network inspect platform-training-net &>/dev/null; then
    # Si no existe, crea la red
    sudo docker network create --driver bridge platform-training-net
else
    echo "La red 'platform-training-net' ya existe."
fi

# Stop containers
sudo docker stop platform-training-springboot
sudo docker stop platform-training-angular

# Habilita permisos de ejecución
sudo chmod +x ./scripts/install/java.sh
sudo chmod +x ./scripts/install/angular.sh

sudo bash `./scripts/install/java.sh`
sudo bash `./scripts/install/angular.sh`