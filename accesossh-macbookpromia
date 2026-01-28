#!/bin/bash

# Tu usuario de GitHub
GITHUB_USER="arturinho16"

# Crear carpeta SSH si no existe
mkdir -p ~/.ssh

# Descargar llave pública desde GitHub
curl -s https://github.com/$GITHUB_USER.keys >> ~/.ssh/authorized_keys

# Ajustar permisos
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo "✅ Llave SSH de $GITHUB_USER agregada correctamente."
