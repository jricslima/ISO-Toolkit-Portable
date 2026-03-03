#!/bin/bash
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"

# CAMADA DE DECISÃO EXTRA
zenity --question --title="Confirmar Integração" \
       --text="Você está prestes a criar um atalho no seu menu de aplicativos.\n\n<b>Deseja continuar?</b>" \
       --ok-label="Sim, instalar" --cancel-label="Desistir" \
       --window-icon="$DIR_ATUAL/icon.png" --width=350

if [ $? -eq 0 ]; then
    # Se o usuário confirmou, executa a ação
    LANCADOR_LOCAL="$DIR_ATUAL/ISO-Toolkit.desktop"
    LANCADOR_SISTEMA="$HOME/.local/share/applications/ISO-Toolkit.desktop"

    cat << EOF > "$LANCADOR_LOCAL"
[Desktop Entry]
Type=Application
Name=ISO Toolkit Portable
Exec=bash "$DIR_ATUAL/AppRun"
Icon=$DIR_ATUAL/icon.png
Path=$DIR_ATUAL
Terminal=false
Categories=Utility;
EOF
    chmod +x "$LANCADOR_LOCAL"
    mkdir -p "$HOME/.local/share/applications/"
    cp "$LANCADOR_LOCAL" "$LANCADOR_SISTEMA"
    touch "$DIR_ATUAL/.atalho_integrado"

    zenity --info --title="ISO Toolkit" --text="Sucesso! O aplicativo foi integrado ao seu menu."
else
    exit 0
fi
