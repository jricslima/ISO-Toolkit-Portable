#!/bin/bash
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"

# 1. Verificação de Dependência
if command -v yad >/dev/null 2>&1; then
    MODO="yad"
    IMG_DIV="$DIR_ATUAL/icones/dividir-iso.png"
    IMG_UNI="$DIR_ATUAL/icones/unir-iso.png"
    IMG_VER="$DIR_ATUAL/icones/verificar-hash-iso.png"
    IMG_CHK="$DIR_ATUAL/icones/criar-cheksum-iso.png"
    IMG_ISO="$DIR_ATUAL/icones/criar-iso.png"
else
    MODO="zenity"
fi

while true; do

    # 2. Execução do Menu
    if [ "$MODO" == "yad" ]; then
        SAIDA=$(yad --list --title="ISO Toolkit - Modo de Elite" \
            --window-icon="$DIR_ATUAL/icon.png" --width=700 --height=500 --center \
            --text="<span background='#FFF9C4' color='black' font='13' weight='bold'>  🛠️  ISO TOOLKIT - SELECIONE UMA FERRAMENTA  </span>" \
            --column="":IMG --column="Ação" --column="Descrição" \
            --image-column=1 --print-column=2 --separator="|" --hide-header \
            "$IMG_DIV" "Dividir ISO" "Cortar uma ISO em várias partes" \
            "$IMG_UNI" "Unir e Verificar" "Juntar partes e conferir integridade" \
            "$IMG_VER" "Verificar Hash" "Checar se um arquivo é autêntico" \
            "$IMG_CHK" "Criar Checksum" "Gerar relatório SHA256 para arquivos" \
            "$IMG_ISO" "Criar ISO" "Gerar ISO a partir de Pasta ou CD/DVD" \
            --button="⚙️ Configurações":2 \
            --button="Sair":1 --button="OK":0)
        
        RETORNO=$?
        ESCOLHA=$(echo $SAIDA | cut -d'|' -f1)
    else
        ESCOLHA=$(zenity --list --title="ISO Toolkit" --column="Ação" \
            "Dividir ISO" "Unir e Verificar" "Verificar Hash" "Criar Checksum" "Criar ISO" "Configurações")
        RETORNO=$?
    fi

    # 3. Lógica de Redirecionamento e Execução
    if [ $RETORNO -eq 2 ]; then
        # Configurações
        bash "$DIR_ATUAL/configuracoes.sh"
    elif [ -z "$ESCOLHA" ] || [ $RETORNO -eq 1 ]; then
        # Sair
        break
    else
        # Identifica o script
        case "$ESCOLHA" in
            "Dividir ISO") SCRIPT="dividir.sh" ;;
            "Unir e Verificar") SCRIPT="unir.sh" ;;
            "Verificar Hash") SCRIPT="verificador.sh" ;;
            "Criar Checksum") SCRIPT="criador_hash.sh" ;;
            "Criar ISO") SCRIPT="converter_iso.sh" ;;
            "Configurações") SCRIPT="configuracoes.sh" ;;
        esac

        # Executa aguardando a conclusão
        gnome-terminal --wait -- bash -c "bash '$DIR_ATUAL/$SCRIPT'"
    fi
done
