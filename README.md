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
O **ISO Toolkit** utiliza interfaces gráficas modernas para facilitar o seu trabalho. Para que o programa exiba as janelas de interação corretamente, é necessário ter instalado um dos seguintes pacotes no seu sistema:

- **YAD** (Recomendado: oferece a melhor experiência visual).
- **Zenity** (Alternativa: padrão em muitas distribuições baseadas em GNOME).

### Como instalar:
```bash
# Arch Linux
sudo pacman -S yad zenity

# Debian/Ubuntu/Mint
sudo apt install yad zenity
