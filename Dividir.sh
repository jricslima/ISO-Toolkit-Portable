#!/bin/bash

# 1. Selecionar a ISO em qualquer pasta
ISO_CAMINHO=$(zenity --file-selection --title="Selecione a ISO para dividir" --file-filter="*.iso *.img")
[ -z "$ISO_CAMINHO" ] && exit

# Extrair apenas o nome e a pasta para o split funcionar certinho
ISO_NOME=$(basename "$ISO_CAMINHO")
ISO_DIR=$(dirname "$ISO_CAMINHO")

# Entra na pasta da ISO para gerar as partes e o txt lá dentro
cd "$ISO_DIR" || exit

# 2. Definir tamanho
TAMANHO=$(zenity --entry --title="Dividir" --text="Tamanho das partes (ex: 1500M):" --entry-text="1500M")
[ -z "$TAMANHO" ] && exit

# 3. Processamento (Mantendo sua barra de progresso e mensagens coloridas)
(
    echo "20"; printf "\e[1;34m[1/2]\e[0m Dividindo...\n" >&2
    split -b "$TAMANHO" -d "$ISO_NOME" "$ISO_NOME."
    
    echo "80"; printf "\e[1;34m[2/2]\e[0m Gerando hashes...\n" >&2
    sha256sum "$ISO_NOME".* > verificacao.txt
    
    echo "100"
) | zenity --progress --title="Processando" --text="Dividindo ISO..." --percentage=0 --auto-close

# 4. Finalização e Limpeza (Exatamente como você criou)
printf "\e[1;32m✅ CONCLUIDO com sucesso!\e[0m\n" >&2
zenity --info --title="Concluido" --text="Divisao concluida em partes de $TAMANHO."

if zenity --question --title="Limpeza" --text="Deseja apagar a ISO ORIGINAL agora?"; then
    rm -v "$ISO_NOME" >&2
    printf "\e[1;32m🧹 ISO original removida.\e[0m\n" >&2
fi
