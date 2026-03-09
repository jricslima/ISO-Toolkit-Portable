#!/bin/bash

# GPS do Diretório
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"
LANCADOR_SISTEMA="$HOME/.local/share/applications/ISO-Toolkit.desktop"
ICONE_SISTEMA="$HOME/.local/share/icons/iso-toolkit-icon.png"

# CAMADA DE DECISÃO EXTRA
zenity --question --title="Confirmar Remoção" \
       --text="Isso removerá o atalho do menu e o ícone do sistema.\nSua pasta e ficheiros continuarão intactos.\n\n<b>Tem certeza?</b>" \
       --ok-label="Sim, remover" --cancel-label="Manter atalho" \
       --window-icon="$DIR_ATUAL/icon.png" --width=350

if [ $? -eq 0 ]; then
    # 1. REMOVE O LANÇADOR DO MENU
    if [ -f "$LANCADOR_SISTEMA" ]; then
        rm "$LANCADOR_SISTEMA"
    fi

    # 2. REMOVE O ÍCONE DO SISTEMA (Limpeza total)
    if [ -f "$ICONE_SISTEMA" ]; then
        rm "$ICONE_SISTEMA"
    fi

    # 3. LIMPA A TRAVA DE MEMÓRIA E O LANÇADOR LOCAL
    rm -f "$DIR_ATUAL/.atalho_integrado"
    rm -f "$DIR_ATUAL/ISO-Toolkit.desktop"

    zenity --info --title="ISO Toolkit" --text="Removido! O atalho e os ficheiros de sistema foram limpos."
else
    exit 0
fi
