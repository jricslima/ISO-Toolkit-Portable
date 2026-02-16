#!/bin/bash
# Seleção do arquivo que VOCÊ zipou
FILE=$(zenity --file-selection --title="Criar Assinatura para seu Projeto")
[ -z "$FILE" ] && exit

(
    MD5_RES=$(md5sum "$FILE" | awk '{print $1}')
    SHA1_RES=$(sha1sum "$FILE" | awk '{print $1}')
    SHA256_RES=$(sha256sum "$FILE" | awk '{print $1}')
    echo "$MD5_RES|$SHA1_RES|$SHA256_RES" > /tmp/hashes_criador.txt
) | zenity --progress --title="ISO Toolkit" --text="Gerando códigos para o seu lançamento..." --pulsate --auto-close

IFS="|" read -r MD5_RES SHA1_RES SHA256_RES < /tmp/hashes_criador.txt
rm /tmp/hashes_criador.txt

# Exportação direta para TXT (Sem perguntas extras)
DIRETORIO=$(dirname "$FILE")
{
    echo "=================================================="
    echo "   VERIFICAÇÃO DE INTEGRIDADE - ISO TOOLKIT"
    echo "=================================================="
    echo "ARQUIVO: $(basename "$FILE")"
    echo "SHA-256: $SHA256_RES"
    echo "MD5:     $MD5_RES"
    echo "SHA-1:   $SHA1_RES"
    echo "=================================================="
} > "$DIRETORIO/checksums.txt"

zenity --info --title="Sucesso" --text="O arquivo 'checksums.txt' foi gerado na pasta do seu projeto!" --width=400
