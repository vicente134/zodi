#!/usr/bin/env bash
set -e

PORT=8090
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! ss -tln | grep -q ":${PORT} "; then
  echo "🚀 Iniciando servidor local en http://localhost:${PORT} ..."
  python3 -m http.server "${PORT}" --bind 0.0.0.0 --directory "${DIR}" >/dev/null 2>&1 &
  sleep 1
fi

echo "🌎 Creando túnel público HTTPS hacia Argentina con Cloudflare..."
echo "👉 Copiá el link que termina en .trycloudflare.com que aparece abajo:"
echo ""
cloudflared tunnel --url "http://localhost:${PORT}"
