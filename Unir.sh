#!/bin/bash

# 1. Selecionar a primeira parte onde quer que ela esteja
ISO_PARTE_CAMINHO=$(zenity --file-selection --title="Selecione a PRIMEIRA PARTE (ex: .iso.00)" --file-filter="*.iso.[0-9]*")
[ -z "$ISO_PARTE_CAMINHO" ] && exit

# Extrair caminhos
ISO_DIR=$(dirname "$ISO_PARTE_CAMINHO")
ISO_PARTE_NOME=$(basename "$ISO_PARTE_CAMINHO")
# Remove a extensão numérica (ex: arquivo.iso.00 -> arquivo.iso)
ISO_NOME="${ISO_PARTE_NOME%.*}"

# Viaja até a pasta das partes para trabalhar lá
cd "$ISO_DIR" || exit

# 2. Pedir o Hash do site (como no seu original)
H_SITE=$(zenity --entry --title="Verificador Universal" --text="Cole o SHA256 do site:")
[ -z "$H_SITE" ] && exit

# 3. Bloco de processamento (Mantendo suas mensagens e lógica de tmp)
(
    echo "10"; printf "\e[1;34m[1/2]\e[0m Unindo arquivos ISO...\n" >&2
    cat "$ISO_NOME".* > "$ISO_NOME"
    
    echo "60"; printf "\e[1;34m[2/2]\e[0m Calculando Hash...\n" >&2
    H_CALC=$(sha256sum "$ISO_NOME" | cut -d' ' -f1)
    echo "100"
    
    printf "\e[1;37m-------------------------------------------\e[0m\n" >&2
    printf "\e[1;33mHash Informado: \e[0m %s\n" "$H_SITE" >&2
    printf "\e[1;36mHash Calculado: \e[0m %s\n" "$H_CALC" >&2
    
    echo "$H_CALC" > /tmp/h_calc.txt
) | zenity --progress --title="Processando" --text="Unindo arquivos..." --percentage=0 --auto-close

H_CALC=$(cat /tmp/h_calc.txt)
rm /tmp/h_calc.txt

# 4. Resultado Final e Limpeza (Exatamente seu fluxo)
if [ "$H_SITE" = "$H_CALC" ]; then
    printf "\e[1;32m✅ SUCESSO: Os hashes coincidem!\e[0m\n" >&2
    zenity --info --title="Sucesso" --text="SUCESSO - O ARQUIVO ESTA PERFEITO"
    
    if zenity --question --title="Limpeza" --text="Deseja apagar as partes numeradas agora?"; then
        rm -v "$ISO_NOME".[0-9]* >&2
        printf "\e[1;32m🧹 Partes removidas.\e[0m\n" >&2
    fi
else
    printf "\e[1;31m❌ ALERTA: O Hash e diferente!\e[0m\n" >&2
    zenity --error --title="Erro" --text="ERRO - O HASH NAO BATE!"
fi
