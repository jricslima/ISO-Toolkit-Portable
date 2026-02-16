#!/bin/bash

# 1. Selecionar o arquivo
FILE=$(zenity --file-selection --title="Selecione o arquivo")
[ -z "$FILE" ] && exit

# 2. Janela de Progresso (Para o usuário não achar que quebrou! kkk)
# O comando ( ... ) & e o 'pulsate' fazem a barra ficar indo e voltando
(
    MD5_RES=$(md5sum "$FILE" | awk '{print $1}')
    SHA1_RES=$(sha1sum "$FILE" | awk '{print $1}')
    SHA256_RES=$(sha256sum "$FILE" | awk '{print $1}')
    
    # Salva os resultados em um arquivo temporário para o script ler depois
    echo "$MD5_RES|$SHA1_RES|$SHA256_RES" > /tmp/hashes.txt
) | zenity --progress --title="Calculando..." --text="Processando arquivo: $(basename "$FILE")\nPor favor, aguarde..." --pulsate --auto-close

# Lê os resultados do arquivo temporário
IFS="|" read -r MD5_RES SHA1_RES SHA256_RES < /tmp/hashes.txt
rm /tmp/hashes.txt

# 3. Janela Única de Formulário (O seu MD5 Utility)
RESULT=$(zenity --forms --title="MD5 & SHA Checksum Utility - Linux" \
    --text="Arquivo: $(basename "$FILE")\n\nMD5: $MD5_RES\nSHA-1: $SHA1_RES\nSHA-256: $SHA256_RES" \
    --separator="|" \
    --add-entry="Cole o Hash para comparar:")

[ -z "$RESULT" ] && exit

# 4. Comparação
HASH_COLADO=$(echo "$RESULT" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

if [ -n "$HASH_COLADO" ]; then
    if [[ "$HASH_COLADO" == "$MD5_RES" || "$HASH_COLADO" == "$SHA1_RES" || "$HASH_COLADO" == "$SHA256_RES" ]]; then
        zenity --info --title="Resultado" --text="✅ VERIFICADO!\n\nO hash coincide com o arquivo." --width=300
    else
        zenity --error --title="Resultado" --text="❌ ERRO!\n\nO hash NÃO coincide!" --width=300
    fi
fi
