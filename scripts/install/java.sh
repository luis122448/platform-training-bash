#!/bin/bash

cd /home/$SERVER_USER/platform-training

# Verifica si el directorio platform-training-springboot no existe
if [ ! -d "platform-training-springboot" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/platform-training-springboot.git
    cd platform-training-springboot
else
    git config --global --add safe.directory ./platform-training-springboot
    cd platform-training-springboot
    git pull origin main
fi

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
POSTGRES_HOST=${SERVER_HOST}
POSTGRES_PORT=5432
POSTGRES_DATABASE=${DATABASE_NAME}
POSTGRES_USERNAME=${DATABASE_USERNAME}
POSTGRES_PASSWORD=${DATABASE_PASSWORD}
EOF

# Deploy container
sudo bash deploy.sh