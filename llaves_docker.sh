#!/bin/bash
set -e

# ================================
# CONFIG
# ================================
GITHUB_USER="arturinho16"
TARGET_USER="arturcm"
TARGET_HOME="/home/$TARGET_USER"

echo "🚀 Iniciando bootstrap del servidor..."

# ================================
# UPDATE
# ================================
echo "📦 Actualizando sistema..."
apt update -y && apt upgrade -y

# ================================
# SSH SERVER
# ================================
echo "🔐 Instalando y habilitando OpenSSH Server..."
apt install openssh-server -y
systemctl enable ssh
systemctl start ssh

# ================================
# SSH KEYS
# ================================
echo "🔑 Configurando SSH para $TARGET_USER desde GitHub..."

mkdir -p $TARGET_HOME/.ssh
curl -fsSL https://github.com/$GITHUB_USER.keys >> $TARGET_HOME/.ssh/authorized_keys

chown -R $TARGET_USER:$TARGET_USER $TARGET_HOME/.ssh
chmod 700 $TARGET_HOME/.ssh
chmod 600 $TARGET_HOME/.ssh/authorized_keys

echo "✅ Llave SSH instalada para $TARGET_USER"

# ================================
# DOCKER
# ================================
echo "🐳 Instalando Docker..."
apt install docker.io -y
systemctl enable docker
systemctl start docker

usermod -aG docker $TARGET_USER

# ================================
# DONE
# ================================
echo "🎉 Bootstrap completo."
echo "👉 Cierra sesión y vuelve a entrar para usar Docker sin sudo."
echo "👉 SSH ya está activo en el puerto 22."

