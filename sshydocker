#!/bin/bash

# ================================
# CONFIGURACIÓN INICIAL
# ================================

# Tu usuario de GitHub
GITHUB_USER="arturinho16"

echo "🔐 Configurando acceso SSH desde GitHub..."

# Crear carpeta SSH si no existe
mkdir -p ~/.ssh

# Descargar llave pública desde GitHub
curl -s https://github.com/$GITHUB_USER.keys >> ~/.ssh/authorized_keys

# Ajustar permisos
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo "✅ Llave SSH agregada correctamente."

# ================================
# ACTUALIZACIÓN DEL SISTEMA
# ================================

echo "📦 Actualizando sistema..."

apt update -y
apt upgrade -y

echo "✅ Sistema actualizado."

# ================================
# INSTALACIÓN DE DOCKER
# ================================

echo "🐳 Instalando Docker..."

apt install docker.io -y

echo "✅ Docker instalado."

# ================================
# INSTALACIÓN DE DOCKER COMPOSE
# ================================

echo "🔧 Instalando Docker Compose..."

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

echo "✅ Docker Compose instalado:"
docker-compose --version

# ================================
# FINALIZADO
# ================================

echo "🎉 Configuración completa. El servidor está listo para usarse."

