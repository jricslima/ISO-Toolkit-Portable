#!/bin/bash

# GPS do Diretório com proteção total para espaços
DIR_ATUAL="$(cd "$(dirname "$0")" && pwd)"
LANCADOR_SISTEMA="$HOME/.local/share/applications/ISO-Toolkit.desktop"
ICONE_SISTEMA="$HOME/.local/share/icons/iso-toolkit-icon.png"

# CAMADA DE DECISÃO
zenity --question --title="Confirmar Integração" \
       --text="Deseja integrar o <b>ISO Toolkit</b> ao seu menu?\n\n<i>Nota: O ícone será fixado no sistema.</i>" \
       --ok-label="Sim, instalar" --cancel-label="Desistir" \
       --window-icon="$DIR_ATUAL/icon.png" --width=400

if [ $? -eq 0 ]; then
    # 1. CRIAR ESTRUTURA DE PASTAS
    mkdir -p "$HOME/.local/share/applications/"
    mkdir -p "$HOME/.local/share/icons/"

    # 2. COPIAR ÍCONE (Essencial para persistência no AppImage)
    cp "$DIR_ATUAL/icon.png" "$ICONE_SISTEMA" 2>/dev/null

    # 3. CRIAR LANÇADOR DIRETAMENTE NO DESTINO (Evita erros de cópia)
    # IMPORTANTE: Aspas em volta de $DIR_ATUAL no campo Exec e Path
    cat << EOF > "$LANCADOR_SISTEMA"
[Desktop Entry]
Version=1.0
Type=Application
Name=ISO Toolkit Portable
Comment=Gerenciador de ISOs
Exec=bash "$DIR_ATUAL/AppRun"
Icon=$ICONE_SISTEMA
Path=$DIR_ATUAL
Terminal=false
Categories=Utility;
Keywords=iso;toolkit;
StartupNotify=true
EOF

    # 4. DEFINIR PERMISSÕES
    chmod +x "$LANCADOR_SISTEMA"
    
    # 5. FORÇAR O SISTEMA A LER O NOVO ATALHO (O segredo que faltava)
    update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null

    # 6. MARCAR COMO INTEGRADO
    touch "$DIR_ATUAL/.atalho_integrado"

    zenity --info --title="Sucesso" --text="Integração concluída!\n\nSe não aparecer de imediato, procure por 'ISO Toolkit' no seu menu." --width=350
else
    exit 0
fi
