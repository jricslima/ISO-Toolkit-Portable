#!/bin/bash
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"

while true; do
    ESCOLHA=$(zenity --list --title="ISO Toolkit - Configurações" --width=400 --height=300 \
        --column="Opção" --column="Descrição" \
        "1" "Integrar Aplicativo ao Menu" \
        "2" "Remover Aplicativo do Menu" \
        "3" "Voltar ao Menu Principal" \
        --window-icon="$DIR_ATUAL/icon.png" --text="Gerencie a presença do Toolkit no seu sistema:")

    case $ESCOLHA in
        "1") bash "$DIR_ATUAL/Integrar ao Menu.sh" ;;
        "2") bash "$DIR_ATUAL/Remover do Menu.sh" ;;
        "3"|"") break ;; # Sai do loop e volta
    esac
done
