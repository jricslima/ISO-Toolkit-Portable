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

# Limpa e exibe o cabeçalho corretamente

cabecalho "VERIFICADOR IMAGEM ISO"

clear
cabecalho

# 2. Seleção do Arquivo
echo -e "${BRANCO}Aguardando seleção de arquivo...${SEM_COR}"
FILE=$(zenity --file-selection --title="Selecione o arquivo para verificar" --window-icon="$DIR_ATUAL/icon.png")

if [ -z "$FILE" ]; then 
    echo -e "${VERMELHO}Operação cancelada pelo usuário.${SEM_COR}"
    exit
fi

NOME_ARQUIVO=$(basename "$FILE")
echo -e "${BRANCO}Arquivo selecionado: $NOME_ARQUIVO${SEM_COR}"

# 3. Cálculo de Hashes com Progresso e Feedback no Terminal
echo -e "${BRANCO}Iniciando cálculos de integridade...${SEM_COR}"

(
    # MD5
    echo "# Calculando MD5..."
    MD5_RES=$(md5sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}MD5:    ${SEM_COR} $MD5_RES" > /dev/tty
    
    # SHA-1
    echo "# Calculando SHA-1..."
    SHA1_RES=$(sha1sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}SHA-1:  ${SEM_COR} $SHA1_RES" > /dev/tty
    
    # SHA-256
    echo "# Calculando SHA-256..."
    SHA256_RES=$(sha256sum "$FILE" | awk '{print $1}')
    echo -e "${ABOBORA}SHA-256:${SEM_COR} $SHA256_RES" > /dev/tty
    
    echo "$MD5_RES|$SHA1_RES|$SHA256_RES" > /tmp/hashes.txt
) | zenity --progress --title="Calculando..." --text="Processando: $NOME_ARQUIVO\nPor favor, aguarde..." --pulsate --auto-close

IFS="|" read -r MD5_RES SHA1_RES SHA256_RES < /tmp/hashes.txt
rm /tmp/hashes.txt

echo -e "\n${VERDE}Todos os hashes foram gerados com sucesso!${SEM_COR}"

# 4. Interface de Comparação (Zenity Forms)
RESULT=$(zenity --forms --title="MD5 & SHA Checksum Utility" \
    --text="Arquivo: $NOME_ARQUIVO\n\nMD5: $MD5_RES\nSHA-1: $SHA1_RES\nSHA-256: $SHA256_RES" \
    --separator="|" \
    --add-entry="Cole o Hash aqui para comparar:" \
    --window-icon="$DIR_ATUAL/icon.png")

if [ -z "$RESULT" ]; then 
    echo -e "${BRANCO}Comparação ignorada.${SEM_COR}"
    exit
fi

# 5. Lógica de Comparação e Resultado Final
HASH_COLADO=$(echo "$RESULT" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

if [ -n "$HASH_COLADO" ]; then
    echo -e "\n${BRANCO}Comparando hash colado...${SEM_COR}"
    
    if [[ "$HASH_COLADO" == "$MD5_RES" || "$HASH_COLADO" == "$SHA1_RES" || "$HASH_COLADO" == "$SHA256_RES" ]]; then
        echo -e "${VERDE}✅ SUCESSO: O hash coincide perfeitamente!${SEM_COR}"
        zenity --info --title="Resultado" --text="✅ VERIFICADO!\n\nO hash coincide com o arquivo." --width=350 --window-icon="$DIR_ATUAL/icon.png"
    else
        echo -e "${VERMELHO}❌ ERRO: O hash colado NÃO coincide!${SEM_COR}"
        zenity --error --title="Resultado" --text="❌ ERRO!\n\nO hash NÃO coincide!" --width=350 --window-icon="$DIR_ATUAL/icon.png"
    fi
fi

# Removido o 'read' para o terminal fechar sozinho ao clicar em OK
echo -e "\n${BRANCO}Módulo finalizado.${SEM_COR}"

 
