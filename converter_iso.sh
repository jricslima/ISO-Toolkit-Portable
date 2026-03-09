#!/bin/bash

# 0. AUTOCONFIGURAÇÃO DE DIRETÓRIO (O SEU GPS)
# Captura o caminho onde a pasta está agora
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"


# 0. Garante que ele ache o estilo.sh não importa onde seja aberto
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$DIR_ATUAL/estilo.sh" ]; then
    source "$DIR_ATUAL/estilo.sh"
else
    # Caso não ache o estilo, define cores básicas para não dar erro
    VERDE="\e[32m"; AMARELO="\e[33m"; RESET="\e[0m"
    cabecalho() { echo -e "${VERDE}=== $1 ===${RESET}"; }
fi

cabecalho "CRIADOR DE IMAGEM ISO"

# Limpa e exibe o cabeçalho corretamente

clear
cabecalho

# 1. Seleciona a pasta de ORIGEM (o conteúdo que vai virar ISO)
ORIGEM=$(zenity --file-selection --directory --title="Passo 1: Selecione a pasta de ORIGEM")

# Se o usuário cancelar, sai do script
if [ -z "$ORIGEM" ]; then exit; fi

# 2. Seleciona o DESTINO e o NOME da ISO
# O --filename já sugere um nome padrão na pasta Downloads
DESTINO=$(zenity --file-selection --save --confirm-overwrite \
--title="Passo 2: Onde deseja salvar e qual o nome da ISO?" \
--filename="$HOME/Downloads/meu_projeto.iso" \
--file-filter="Arquivos ISO | *.iso")

# Se o usuário cancelar, sai do script
if [ -z "$DESTINO" ]; then exit; fi

# 3. Garante que o destino tenha a extensão .iso
if [[ $DESTINO != *.iso ]]; then
    DESTINO="$DESTINO.iso"
fi

# 4. Inicia a criação da ISO e do HASH
(
echo "# Criando a imagem ISO..."
# O comando mkisofs ou genisoimage (dependendo do seu sistema)
genisoimage -o "$DESTINO" -V "ISO_TOOLKIT" -r -J "$ORIGEM"

echo "# Gerando o código HASH (SHA256)..."
sha256sum "$DESTINO" > "$DESTINO.sha256.txt"

) | zenity --progress --title="ISO Toolkit v2.0" --text="Processando..." --pulsate --auto-close

# 5. Aviso final
zenity --info --text="Sucesso!\n\nISO: $DESTINO\nHASH: $DESTINO.sha256.txt" --title="Concluído"


