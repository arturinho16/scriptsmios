#!/bin/bash
set -e

# ================================
# CONFIG
# ================================
GITHUB_USER="arturinho16"
TARGET_USER="arturcm"
TARGET_HOME="/home/$TARGET_USER"

echo "🚀 Iniciando bootstrap del servidor (Rocky Linux 8)..."

# ================================
# UPDATE SYSTEM
# ================================
echo "📦 Actualizando sistema..."
dnf update -y

# ================================
# SSH SERVER
# ================================
echo "🔐 Instalando y habilitando OpenSSH Server..."
dnf install -y openssh-server

systemctl enable sshd
systemctl start sshd

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
# DOCKER INSTALL
# ================================
echo "🐳 Instalando Docker CE..."

dnf install -y dnf-utils
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

systemctl enable docker
systemctl start docker

# ================================
# DOCKER USER PERMISSIONS
# ================================
usermod -aG docker $TARGET_USER

# ================================
# FIREWALL (opcional pero recomendado)
# ================================
echo "🔥 Configurando firewall para SSH..."
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload

# ================================
# DONE
# ================================
echo "🎉 Bootstrap completo en Rocky Linux 8."
echo "👉 Cierra sesión y vuelve a entrar para usar Docker sin sudo."
echo "👉 SSH activo en el puerto 22."
