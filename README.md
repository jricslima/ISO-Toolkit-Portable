<p align="center">
  <img src="icones/iso-toolkit-icon.png" alt="Logo ISO Toolkit" width="120">
</p>

# 🛡️ ISO Toolkit Elite v2.2.5 (Dual-Mode Edition)

O **ISO Toolkit** é a ferramenta definitiva para manipulação de imagens ISO no Linux Mint. Esta versão oferece flexibilidade total, permitindo o uso como um arquivo único **AppImage** ou como uma **Pasta Portable** de alta performance.

<p align="center">
  <a href="https://github.com/jricslima/ISO-Toolkit-Portable/releases/latest">
    <img src="https://img.shields.io/badge/Download-ISO_Toolkit_Portable-2ea44f?style=for-the-badge&logo=github&logoColor=white" alt="Download ISO Toolkit">
  </a>
</p>

---

## 🚀 Escolha seu Modo de Elite
O Toolkit adapta-se à sua necessidade através do script inteligente `AppRun`:

- **📦 Modo AppImage (Arquivo Único):** Ideal para transporte em Pens USB. Um único executável que detecta automaticamente se o seu sistema possui **YAD** ou **Zenity** para rodar em qualquer lugar.
- **📂 Modo Portable (Pasta Integrada):** Recomendado para uso diário. Permite fixar o ícone permanentemente no **Plank** ou na barra de tarefas através da integração nativa.

---

## 📋 Requisitos de Sistema
O **ISO Toolkit** utiliza interfaces gráficas modernas. É necessário ter instalado um dos seguintes pacotes:

- **YAD** (Recomendado: oferece a melhor experiência visual).
- **Zenity** (Alternativa: padrão em muitas distribuições GNOME).

### Como instalar:
```bash
# Arch Linux
sudo pacman -S yad zenity

# Debian/Ubuntu/Mint
sudo apt install yad zenity

🚀 Funcionalidades Principais
✂️ Dividir ISO: Suporte automático para ficheiros superiores a 4GB.

🔗 Unir e Verificar: Reconstituição com validação SHA-256.

🛡️ Verificar Hash: Validação instantânea de assinaturas criptográficas.

📝 Criar Checksum: Geração de relatórios (MD5, SHA-1, SHA-256).

💿 Criar ISO: Conversão direta de pastas ou discos

🖥️ Instalação e Configuração
Se usar o AppImage:
Dê permissão de execução: chmod +x ISO_Toolkit-x86_64.AppImage.

Execute o arquivo. O sistema perguntará se deseja criar o atalho no menu.

Se usar a Pasta Portable:
Extraia o conteúdo para uma pasta de sua preferência (Ex: ~/Portable/).

No terminal, dê permissão: chmod +x *.sh AppRun.

Execute o AppRun e use o botão ⚙️ Configurações para integrar ao sistema.

💡 Dica para usuários do Plank: Utilize sempre o Modo Portable e realize a integração através do painel de configurações interno para manter o ícone fixo na barra de forma persistente.

📂 Estrutura de Arquivos
AppRun: O cérebro do projeto.

configuracoes.sh: Painel de gestão para integrar/remover do sistema.

icones/: Galeria de recursos visuais.

menu.sh: Interface principal com visual premium.
