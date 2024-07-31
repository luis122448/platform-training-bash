#!/bin/bash

cd /home/$SERVER_USER/platform-training

# Verifica si el directorio platform-training-angular no existe
if [ ! -d "platform-training-angular" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/platform-training-angular.git
    cd platform-training-angular
else
    git config --global --add safe.directory ./platform-training-angular
    cd platform-training-angular
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=https://platform-training.luis122448.dev/app-project
API_SUNAT_TOKEN=lCSzUmWQLRZT4ytYL3EgHCKTBh7K2dswFaFjsB1nKkq6RIaGB0AuRD2qvtsxm8q4
EOF

# Deploy container
sudo bash deploy.sh