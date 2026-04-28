#!/usr/bin/env bash
set -euo pipefail

# Configuração
BUILD_DIR="dist"
REMOTE_USER="${DEPLOY_USER:-mechanical-advogados}"
REMOTE_HOST="${DEPLOY_HOST:-168.231.113.60}"
REMOTE_PATH="${DEPLOY_PATH:-/home/mechanical-advogados/htdocs/advogados.mechanical.co.mz}"

if [[ -z "${REMOTE_USER}" || -z "${REMOTE_HOST}" ]]; then
  echo "Defina DEPLOY_USER/DEPLOY_HOST no ambiente antes de executar o script."
  exit 1
fi

# Gera build de produção (usa VITE_API_BASE_URL do .env.production/.env.production.local)
npm run build

# Sincroniza os arquivos gerados
rsync -avz --delete "${BUILD_DIR}/" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo "Deploy concluído em ${REMOTE_HOST}:${REMOTE_PATH}"
