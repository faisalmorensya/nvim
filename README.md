### nvim-config

Based on [catppuccin](https://github.com/catppuccin) colorscheme, suitable for React/NextJS/Golang programming.

## Installation

### Prerequisites

1. Install [Neovim](https://github.com/neovim/neovim/releases) (v0.9+)
2. Install [git](https://git-scm.com/)
3. Install [Node.js](https://nodejs.org/) (for LSP servers and formatters)
4. Install [ripgrep](https://github.com/BurntSushi/ripgrep) (for text search)
5. Install [fd](https://github.com/sharkdp/fd) (for file search)

### macOS

```bash
# Install dependencies
brew install neovim git node ripgrep fd

# Clone the config
git clone https://github.com/faisalmorensya/nvim-config.git ~/.config/nvim
```

### Linux (Ubuntu/Debian)

```bash
# Install dependencies
sudo apt install neovim git nodejs npm riprep fd-find

# Clone the config
git clone https://github.com/faisalmorensya/nvim-config.git ~/.config/nvim
```

### Windows (WSL)

```bash
# Install dependencies
sudo apt install neovim git nodejs npm ripgrep fd-find

# Clone the config
git clone https://github.com/faisalmorensya/nvim-config.git ~/.config/nvim
```

## First Run

On first launch, Neovim will automatically:
- Install [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
- Install all configured plugins
- Install LSP servers and formatters

This may take a few minutes on first run.

#### auto import
<img width="2168" alt="image" src="https://github.com/user-attachments/assets/adf3b70c-6bf2-4e26-9a16-f5eadb405c4b">

#### instant error feedback
<img width="2168" alt="image" src="https://github.com/user-attachments/assets/1e8dad9f-0181-483a-8e8a-d61243aafa3f">

#### split screen
<img width="2168" alt="image" src="https://github.com/user-attachments/assets/6d4661b8-b04c-4210-84c3-89a65728ac00">

#### file search
<img width="2168" alt="image" src="https://github.com/user-attachments/assets/8fc31634-1133-4c86-bc9c-146c44deaed1">

#### text search
<img width="2168" alt="image" src="https://github.com/user-attachments/assets/827fdaa9-373d-4b1b-b7bb-c70d7cc38ab1">
