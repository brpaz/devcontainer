# syntax=docker/dockerfile:1

# ============================================
# Base Stage
# ============================================
FROM debian:trixie-slim

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG ZELLIJ_VERSION=v0.44.1
ARG TV_VERSION=0.15.6
ARG LAZYGIT_VERSION=0.61.1
ARG LAZYDOCKER_VERSION=0.25.0
ARG DELTA_VERSION=0.19.2

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
		curl \
		git \
		fzf \
		zsh \
		sudo \
		ripgrep \
		fd-find \
		lazygit \
		direnv \
		bat \
		unzip \
		eza \
		xz-utils \
		extrepo \
		gpg \
		docker-cli \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd --gid $USER_GID $USERNAME \
		&& useradd -rm -d /home/$USERNAME -s /bin/zsh --gid $USERNAME --groups sudo -u $USER_UID $USERNAME \
		&& echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
		&& groupadd docker && usermod -aG docker $USERNAME

WORKDIR /home/${USERNAME}

# Install nerd fonts (JetBrains Mono Nerd Font)
RUN mkdir -p /usr/share/fonts && \
	curl -sSfL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz | tar -xJf - -C /usr/share/fonts/ && \
	rm -f JetBrainsMono.tar.xz

# Install zellij
RUN curl -sSfL https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C /usr/local/bin \
	&& zellij --version

# Install tv (television)
RUN curl -sSfL https://github.com/alexpasmantier/television/releases/download/${TV_VERSION}/tv-${TV_VERSION}-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C /tmp/ \
	&& mv /tmp/tv-${TV_VERSION}-x86_64-unknown-linux-gnu/tv /usr/local/bin/tv \
	&& chmod +x /usr/local/bin/tv \
	&& tv --version \
	&& tv update-channels

# Install Node and global packages
RUN extrepo enable node_24.x && \
	apt-get update && \
	apt-get install -y nodejs && \
	node --version && \
	npm install -g @commitlint/cli @commitlint/config-conventional czg

# Install Taskfile
RUN curl --location https://taskfile.dev/install.sh | sh -s -- -d

# Install delta
RUN curl -sSfL https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C /tmp \
  && mv /tmp/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta /usr/local/bin/delta \
	&& delta --version

# hl log viewer
RUN curl -sSfL https://github.com/pamburus/hl/releases/latest/download/hl-linux-x86_64-musl.tar.gz | tar xz -C /usr/local/bin hl && \
	chmod +x /usr/local/bin/hl && \
	hl --version

# D4s
RUN curl -fsSL https://apt.d4scli.io/d4s.gpg.key | gpg --dearmor -o /usr/share/keyrings/d4s.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/d4s.gpg] https://apt.d4scli.io stable main" | sudo tee /etc/apt/sources.list.d/d4s.list && \
	apt update && \
	apt install -y d4s

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER ${USERNAME}

RUN mkdir -p ~/.local/bin && mkdir -p ~/.config && mkdir ~/.zshrc.d

# Install Mise en place
RUN curl https://mise.run | sh

# Install starship
RUN curl -sSfL https://starship.rs/install.sh | sh -s -- --yes -b ~/.local/bin

# Install fnm (Fast Node Manager)
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "./.fnm" --skip-shell

# Install zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Installs nix
COPY dotfiles/etc/nix.conf /etc/nix/nix.conf

RUN curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --no-daemon && \
  export PATH="$HOME/.nix-profile/bin:$PATH" && \
  nix --version && \
  nix profile install nixpkgs#devenv

COPY --chown=$USER_UID:$USER_GID dotfiles/zsh_plugins.txt /home/$USERNAME/.zsh_plugins.txt
COPY --chown=$USER_UID:$USER_GID dotfiles/zshrc /home/$USERNAME/.zshrc
COPY --chown=$USER_UID:$USER_GID dotfiles/config /home/${USERNAME}/.config

ENTRYPOINT [ "/entrypoint.sh" ]
