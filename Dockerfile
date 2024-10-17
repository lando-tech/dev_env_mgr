FROM ubuntu:22.04

LABEL maintainer="Aaron Newman aaron.newman@landotech.io"
LABEL version="1.0"

# Update and install necessary packages
RUN apt update && \
    apt install -y \
        neovim \
        git \
        curl \
        wget \
        vim \
        lua5.4 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy python script
COPY python-dev/setup.py python-dev/setup.py

# Run python script
RUN python3 python-dev/setup.py

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    . $HOME/.cargo/env

# Set up working directory
WORKDIR /home/dev

# Clone necessary repositories
RUN git clone https://github.com/lando-tech/nvim_config.git .configs/nvim && \
    git clone https://github.com/wbthomason/packer.nvim.git && \
    git clone https://github.com/neovim/nvim-lspconfig.git && \
    git clone https://github.com/hrsh7th/cmp-nvim-lua.git && \
    git clone https://github.com/L3MON4D3/LuaSnip.git && \
    git clone https://github.com/terrortylor/nvim-comment.git && \
    git clone https://github.com/rktjmp/lush.nvim.git && \
    git clone https://github.com/nvim-treesitter/nvim-treesitter.git && \
    git clone https://github.com/nvim-tree/nvim-tree.lua.git && \
    git clone https://github.com/nvim-lua/plenary.nvim.git && \
    git clone https://github.com/LuaLS/lua-language-server.git

# Optionally, set up environment variables
ENV PATH="/root/.cargo/bin:${PATH}"

RUN chown -R 1000:1000 /home/dev

RUN useradd -m lando-tech

USER lando-tech

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost/ || exit 1

CMD ["bash"]
