#!/bin/bash
GITLIB_URL="https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main"

# Marcarla como de solo lectura
readonly GITLIB_URL

# Exportarla para que esté disponible en subprocesos
export GITLIB_URL

echo "El valor de GITLIB_URL es: $GITLIB_URL"