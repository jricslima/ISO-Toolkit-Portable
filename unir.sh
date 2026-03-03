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
    VERDE="\e[32m"; AMARELO="\e[33m"; BRANCO="\e[37m"; ABOBORA="\e[38;5;208m"; VERMELHO="\e[31m"; SEM_COR="\e[0m"
    cabecalho() { echo -e "${VERDE}=== $1 ===${SEM_COR}"; }
fi

# Limpa e exibe o cabeçalho corretamente

clear
cabecalho "UNIR IMAGEM ISO"

# 2. Seleção da Parte 00
echo -e "${BRANCO}Selecione a primeira parte (ex: projeto.iso.00)...${SEM_COR}"
PRIMEIRA_PARTE=$(zenity --file-selection --title="Selecionar Parte .00" --window-icon="$DIR_ATUAL/icon.png")
[ -z "$PRIMEIRA_PARTE" ] && exit

# Define o nome da saída removendo o .00
ARQUIVO_FINAL="${PRIMEIRA_PARTE%.*}"
NOME_ISO=$(basename "$ARQUIVO_FINAL")

# 3. União Inteligente com Barra Pulsante (Sintaxe Corrigida)
echo -e "${BRANCO}Unindo partes de $NOME_ISO...${SEM_COR}"

# O segredo está em abrir o ( ) antes do comando e fechar antes do pipe |
(
    rm -f "$ARQUIVO_FINAL" 
    cat "${ARQUIVO_FINAL}.0"* > "$ARQUIVO_FINAL" 2>/dev/null || cat "${ARQUIVO_FINAL}."* > "$ARQUIVO_FINAL"
) | zenity --progress --title="Unindo Arquivos" --text="Unindo as partes da ISO...\nAguarde, isso pode demorar." --pulsate --auto-close --window-icon="$DIR_ATUAL/icon.png"

# 4. Cálculo e Comparação
echo -e "${BRANCO}Calculando SHA256 da união...${SEM_COR}"
HASH_CALCULADO=$(sha256sum "$ARQUIVO_FINAL" | awk '{print $1}')

echo -e "${ABOBORA}Hash da ISO Unida: $HASH_CALCULADO${SEM_COR}"

# 5. Entrada do Hash para Conferência
HASH_INFORMADO=$(zenity --entry --title="Conferir SHA256 (Opcional)" \
--text="Cole o hash para comparar ou deixe em BRANCO para pular:" \
--window-icon="$DIR_ATUAL/icon.png")

if [ -z "$HASH_INFORMADO" ]; then
    echo -e "${AMARELO}⚠️  Verificação de hash pulada pelo usuário.${SEM_COR}"
else
    # Normaliza o hash (remove espaços e deixa em minúsculo)
    HASH_INFORMADO=$(echo "$HASH_INFORMADO" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
    
    if [ "$HASH_CALCULADO" == "$HASH_INFORMADO" ]; then
        echo -e "${VERDE}✅ SUCESSO: O hash coincide perfeitamente!${SEM_COR}"
        zenity --info --title="Resultado" --text="✅ VERIFICADO!\n\nA união foi perfeita." --width=350 --window-icon="$DIR_ATUAL/icon.png"
    else
        echo -e "${VERMELHO}❌ ERRO: O Hash não coincide!${SEM_COR}"
        zenity --error --title="Falha" --text="❌ ATENÇÃO!\n\nO hash informado é diferente do calculado." --width=350 --window-icon="$DIR_ATUAL/icon.png"
    fi
fi

echo -e "\n${BRANCO}Processo concluído.${SEM_COR}"

# 6. Limpeza das partes
if zenity --question --title="Limpeza" --text="Deseja apagar as partes numeradas agora?"; then
    rm -v "$ARQUIVO_FINAL".[0-9]* >&2
    printf "\e[1;32m🧹 Partes removidas.\e[0m\n" >&2
fi

exit 0
