# 🛡️ ISO Toolkit Elite v2.2.5 (Dual-Mode Edition)  
[![Download](https://img.shields.io/badge/DOWNLOAD-ISO--TOOLKIT--V2.2.5-green)](https://github.com/jricslima/ISO-Toolkit-Portable/releases/download/v2.2.5/ISO_Toolkit_Portable-x86_64.AppImage)
   
O **ISO Toolkit** é a ferramenta definitiva para manipulação de imagens ISO no Linux Mint. Esta versão oferece flexibilidade total, permitindo o uso como um arquivo único **AppImage** ou como uma **Pasta Portable** de alta performance.  
   
## 🚀 Escolha seu Modo de Elite  
O Toolkit adapta-se à sua necessidade através do script inteligente `AppRun`:  
   
* **📦 Modo AppImage (Arquivo Único):** Ideal para transporte em Pens USB. Um único executável que detecta automaticamente se o seu sistema possui **YAD** ou **Zenity** para rodar em qualquer lugar.  
* **📂 Modo Portable (Pasta Integrada):** Recomendado para uso diário. Permite fixar o ícone permanentemente no **Plank** ou na barra de tarefas através da integração nativa.  
   
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
