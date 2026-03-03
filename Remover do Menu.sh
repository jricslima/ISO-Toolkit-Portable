#!/bin/bash
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"

# CAMADA DE DECISÃO EXTRA
zenity --question --title="Confirmar Remoção" \
       --text="Isso removerá apenas o atalho do menu.\nSua pasta e arquivos continuarão intactos.\n\n<b>Tem certeza?</b>" \
       --ok-label="Sim, remover" --cancel-label="Manter atalho" \
       --window-icon="$DIR_ATUAL/icon.png" --width=350

if [ $? -eq 0 ]; then
    LANCADOR_SISTEMA="$HOME/.local/share/applications/ISO-Toolkit.desktop"
    if [ -f "$LANCADOR_SISTEMA" ]; then
        rm "$LANCADOR_SISTEMA"
        rm -f "$DIR_ATUAL/.atalho_integrado"
        zenity --info --title="ISO Toolkit" --text="Removido! O atalho foi removido do menu."
    fi
else
    exit 0
fi
