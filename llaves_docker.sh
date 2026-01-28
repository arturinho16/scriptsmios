#!/bin/bash
set -e

# ================================
# CONFIG
# ================================
GITHUB_USER="arturinho16"
TARGET_USER="arturcm"
TARGET_HOME="/home/$TARGET_USER"

echo "🔐 Configurando SSH para $TARGET_USER desde GitHub..."

# Crear .ssh
mkdir -p $TARGET_HOME/.ssh

# Descargar llaves públicas
curl -s https://github.com/$GITHUB_USER.keys >> $TARGET_HOME/.ssh/authorized_keys

# Permisos correctos
chown -R $TARGET_USER:$TARGET_USER $TARGET_HOME/.ssh
chmod 700 $TARGET_HOME/.ssh
chmod 600 $TARGET_HOME/.ssh/authorized_keys

echo "✅ Llave SSH instalada para $TARGET_USER"

# ================================
# UPDATE
# ================================
echo "📦 Actualizando sistema..."
apt update -y && apt upgrade -y

# ================================
# DOCKER
# ================================
echo "🐳 Instalando Docker..."
apt install docker.io -y

# Agregar usuario a docker
usermod -aG docker $TARGET_USER

# ================================
# DOCKER COMPOSE
# ================================
echo "🔧 Instalando Docker Compose..."

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

echo "🎉 Todo listo. Cierra sesión y vuelve a entrar."


