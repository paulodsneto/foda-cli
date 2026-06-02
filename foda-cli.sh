#!/bin/bash

echo "

███████████    ███████    ██████████     █████████                █████████  █████       █████
▒▒███▒▒▒▒▒▒█  ███▒▒▒▒▒███ ▒▒███▒▒▒▒███   ███▒▒▒▒▒███              ███▒▒▒▒▒███▒▒███       ▒▒███ 
 ▒███   █ ▒  ███     ▒▒███ ▒███   ▒▒███ ▒███    ▒███             ███     ▒▒▒  ▒███        ▒███ 
 ▒███████   ▒███      ▒███ ▒███    ▒███ ▒███████████  ██████████▒███          ▒███        ▒███ 
 ▒███▒▒▒█   ▒███      ▒███ ▒███    ▒███ ▒███▒▒▒▒▒███ ▒▒▒▒▒▒▒▒▒▒ ▒███          ▒███        ▒███ 
 ▒███  ▒    ▒▒███     ███  ▒███    ███  ▒███    ▒███            ▒▒███     ███ ▒███      █ ▒███ 
 █████       ▒▒▒███████▒   ██████████   █████   █████            ▒▒█████████  ███████████ █████
▒▒▒▒▒          ▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒              ▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒ 
                                                                                               
                                                                                               
                                                                                               "
sleep 5

echo "🚀 Iniciando a customização FODA do ambiente CLI no WSL2..."

# 1. Atualizar e instalar dependências básicas
echo "📦 Atualizando pacotes e instalando dependências... muito FODA"
sudo apt update && sudo apt install -y zsh git curl tar unzip libc6 libstdc++6

# 2. Instalando o neovim
echo "📝 Baixando e instalando Neovim atualizado... pouco FODa .. né?"
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

# PATH do sistema
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/vim

# Instalando o LazyVim
echo "💤 Configurando LazyVim... preciso nem fala."
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Instalando o omzsh
echo "🐚 Instalando Oh My Zsh... ta de brincadeira.."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh já instalado. Pulando... já que vc era FODA "
fi

# 5. Crianjdo o tema natureza
echo "🎨 Gerando tema visual customizado... agora fica bacana pega"
mkdir -p ~/.oh-my-zsh/custom/themes/
cat <<'EOF' >~/.oh-my-zsh/custom/themes/natureza.zsh-theme
function toon { echo -n "𖠞 ࿔˚.⋆" } 
PROMPT='$(toon) %{$fg[cyan]%}%n@%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} %{$fg[blue]%}>%{$reset_color%} '
EOF

# Aplicar o tema no arquivo de config do zsh ~/.zshrc
sed -i 's/ZSH_THEME="[a-zA-Z0-9_-]*"/ZSH_THEME="natureza"/g' ~/.zshrc

# Corrigir integração do PATH do windows no wsl
#echo "🪟 Configurando integração de binários do Windows (/etc/wsl.conf)... nerd pra caralho kk mas é FODa"
#if ! grep -q "appendWindowsPath" /etc/wsl.conf 2>/dev/null; then
#  echo -e "\n[interop]\nappendWindowsPath = true" | sudo tee -a /etc/wsl.conf >/dev/null
#fi

# Corrigir integração do PATH do windows no wsl verificando se o ambiente é WSL ou Linux nativo
if uname -r | grep -qi "microsoft"; then
  echo "🪟 Ambiente WSL detectado. Configurando integração de binários do Windows... nerd pra caralho kk mas é FODa"
  if ! grep -q "appendWindowsPath" /etc/wsl.conf 2>/dev/null; then
    echo -e "\n[interop]\nappendWindowsPath = true" | sudo tee -a /etc/wsl.conf >/dev/null
  fi
else
  echo "🐧 Ambiente Linux nativo detectado. Pulando configurações do WSL... ainda bem kk"
fi

# Alterar o shell padrão para zsh (Usuário e Root)
echo "🔄 Definindo Zsh como shell padrão... só falta isso agora pprt"
sudo chsh -s $(which zsh) $USER
sudo chsh -s $(which zsh) root

echo "========================================================"
echo "✅ Instalação FODA e customização FODA concluídas com sucesso!"
echo "========================================================"
echo "⚠️  Para aplicar todas as configurações FODA, feche este terminal,"
echo "rode 'wsl --terminate Debian' no PowerShell como Administrador, abra novamente e seja FODA."
echo "FODA-CLI"
