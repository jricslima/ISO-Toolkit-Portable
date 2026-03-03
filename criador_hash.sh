#!/bin/bash

# 0. AUTOCONFIGURAÇÃO DE DIRETÓRIO (O SEU GPS)
# Captura o caminho onde a pasta está agora
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"


# 1. Garante que ele ache o estilo.sh não importa onde seja aberto
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$DIR_ATUAL/estilo.sh" ]; then
    source "$DIR_ATUAL/estilo.sh"
else
    # Caso não ache o estilo, define cores básicas para não dar erro
    VERDE="\e[32m"; AMARELO="\e[33m"; RESET="\e[0m"
    cabecalho() { echo -e "${VERDE}=== $1 ===${RESET}"; }
fi

cabecalho "CRIADOR DE HASH"

# Limpa e exibe o cabeçalho corretamente

clear
cabecalho

# 2. Seleção do Arquivo (Mensagem em BRANCO)
echo -e "${BRANCO}Selecione o arquivo do seu projeto para gerar a assinatura...${SEM_COR}"
FILE=$(zenity --file-selection --title="Criar Assinatura para seu Projeto" --window-icon="$DIR_ATUAL/icon.png")

if [ -z "$FILE" ]; then 
    echo -e "${VERMELHO}Operação cancelada.${SEM_COR}"
    exit
fi

echo -e "${BRANCO}Arquivo selecionado: $(basename "$FILE")${SEM_COR}"

# 3. Geração dos Hashes (Feedback em Branco e Abóbora)
echo -e "${BRANCO}Iniciando geração dos códigos de integridade...${SEM_COR}"

(
    # MD5
    MD5_RES=$(md5sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}MD5 gerado:    $MD5_RES${SEM_COR}" > /dev/tty
    
    # SHA-1
    SHA1_RES=$(sha1sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}SHA-1 gerado:  $SHA1_RES${SEM_COR}" > /dev/tty
    
    # SHA-256
    SHA256_RES=$(sha256sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}SHA-256 gerado:$SHA256_RES${SEM_COR}" > /dev/tty
    
    echo "$MD5_RES|$SHA1_RES|$SHA256_RES" > /tmp/hashes_criador.txt
) | zenity --progress --title="ISO Toolkit" --text="Gerando códigos para o seu lançamento..." --pulsate --auto-close

IFS="|" read -r MD5_RES SHA1_RES SHA256_RES < /tmp/hashes_criador.txt
rm /tmp/hashes_criador.txt

# 4. Exportação para TXT
DIRETORIO=$(dirname "$FILE")
{
    echo "=================================================="
    echo "    VERIFICAÇÃO DE INTEGRIDADE - ISO TOOLKIT"
    echo "=================================================="
    echo "ARQUIVO: $(basename "$FILE")"
    echo "SHA-256: $SHA256_RES"
    echo "MD5:      $MD5_RES"
    echo "SHA-1:    $SHA1_RES"
    echo "=================================================="
} > "$DIRETORIO/checksums.txt"

# 5. Finalização e Fechamento Automático
echo -e "\n${VERDE}✅ SUCESSO! O arquivo 'checksums.txt' foi gerado.${SEM_COR}"
echo -e "${BRANCO}Módulo finalizado.${SEM_COR}"

zenity --info --title="Sucesso" --text="O arquivo 'checksums.txt' foi gerado na pasta do seu projeto!" --width=400 --window-icon="$DIR_ATUAL/icon.png"

# Fecha o terminal automaticamente após o OK
exit 0
