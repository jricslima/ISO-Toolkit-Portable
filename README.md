# 🛡️ ISO Toolkit Elite v2.2.5 (Dual-Mode Edition)  

<a href="https://github.com/jricslima/ISO-Toolkit-Portable/releases/download/v2.2.5/ISO_Toolkit-x86_64.AppImage">
  <img src="https://img.shields.io/badge/DOWNLOAD-ISO--TOOLKIT--V2.2.5-green?style=for-the-badge&logo=linux" alt="Download">
</a>

https://github.com/user-attachments/assets/ef4ac3fd-48aa-42d6-8d7f-fc8b51686a1e

🚀 Interface Moderna: Demonstração do Modo de Elite com integração nativa ao sistema em apenas um clique.
   
O **ISO Toolkit** é a ferramenta definitiva para manipulação de imagens ISO no Linux Mint. Esta versão oferece flexibilidade total, permitindo o uso como um arquivo único **AppImage** ou como uma **Pasta Portable** de alta performance.  
   
## 🚀 Escolha seu Modo de Elite  
O Toolkit adapta-se à sua necessidade através do script inteligente `AppRun`:  
   
* **📦 Modo AppImage (Arquivo Único):** Ideal para transporte em Pens USB. Um único executável que detecta automaticamente se o seu sistema possui **YAD** ou **Zenity** para rodar em qualquer lugar.  
* **📂 Modo Portable (Pasta Integrada):** Recomendado para uso diário. Permite fixar o ícone permanentemente no **Plank** ou na barra de tarefas através da integração nativa.  
   

## 📋 Requisitos de Sistema
O ISO Toolkit utiliza interfaces gráficas modernas para facilitar o seu trabalho. Para que o programa exiba as janelas de interação corretamente, é necessário ter instalado um dos seguintes pacotes no seu sistema:

YAD (Recomendado: oferece a melhor experiência visual).

Zenity (Alternativa: padrão em muitas distribuições baseadas em GNOME).

**Como instalar:**

**Arch Linux:** sudo pacman -S yad zenity

**Debian/Ubuntu/Mint:** sudo apt install yad zenity

## 🛠️ Funcionalidades de Alta Performance  
* **✂️ Dividir ISO:** Fragmentação inteligente com monitorização de progresso.  
* **🔗 Unir e Verificar:** Reconstituição com validação SHA-256 automática.  
* **🛡️ Verificar Hash:** Validação instantânea de assinaturas criptográficas.  
* **📝 Criar Checksum:** Geração de relatórios profissionais em MD5, SHA-1 e SHA-256.  
* **💿 Criar ISO:** Conversão direta de pastas ou discos para o formato .iso.  
   
## 🖥️ Instalação e Configuração  
   
### Se usar o AppImage:  
1. Dê permissão de execução ao arquivo: `chmod +x ISO-Toolkit-x86_64.AppImage`.  
2. Execute o arquivo. No primeiro início, o sistema perguntará se deseja criar o atalho no menu de aplicativos.  
   
### Se usar a Pasta Portable:  
1. Extraia a pasta `ISO-Toolkit.AppDir` para um local de sua preferência (Ex: `~/Portable/`).  
2. No terminal dentro da pasta, execute: `chmod +x *.sh AppRun`.  
3. Execute o **`AppRun`** e use o botão **⚙️ Configurações** no rodapé para integrar o app ao seu sistema.  
   
> **💡 Dica para usuários do Plank:** Para manter o ícone fixo na barra de forma persistente, utilize sempre o **Modo Portable** e realize a integração através do painel de configurações interno.  
   
## 📂 Estrutura de Arquivos  
* **`AppRun`**: O cérebro do projeto. Gerencia ícones, integrações e detecta requisitos do sistema (YAD/Zenity).  
* **`configuracoes.sh`**: Painel de gestão para integrar ou remover o Toolkit do sistema de forma limpa.  
* **`icones/`**: Galeria de discos e sinalizações visuais.  
* **`menu.sh`**: Interface principal com visual premium e discos coloridos.  
* **`scripts/`**: Motores de processamento das ferramentas ISO.  
