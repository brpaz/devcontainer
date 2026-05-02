# Devcontainers

> My personal [devcontainer](https://containers.dev/).

## Features

- ZSH Shell with Antidote Plugin Manager and a curated set of plugins
- Docker in Docker (DinD)
- [Nix](https://nixos.org/)
- [Devenv](https://devenv.sh)
- [Direnv](https://direnv.net/)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- [Fd](https://github.com/sharkdp/fd)
- [Startship Prompt](https://starship.rs/)
- [FZF](https://github.com/junegunn/fzf)
- [Television](https://github.com/alexpasmantier/television)
- [Zellij](https://zellij.dev/)
- [Bat](https://github.com/sharkdp/bat)
- [Eza](https://github.com/eza-community/eza)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [FNM](https://fnm.vercel.app/)
- [Mise en Place](https://mise.jdx.dev/)
- [Task](https://taskfile.dev/)
- [Docker](https://www.docker.com/)
- [GitHub CLI](https://cli.github.com/)
- [Hl](https://github.com/pamburus/hl)

## Getting Started

## Usage

Create a `.devcontainer/devcontainer.json` file in your project with the following content:

```json
{
	"name": "My Devcontainer",
	"image": "ghcr.io/brpaz/devcontainer:latest",
	// ...
}
```

## Development

### Pre requisites

- [devcontainer CLI](https://containers.dev/cli)
- [Docker](https://www.docker.com/)
- [Task](https://taskfile.dev/)

### Building a devcontainer

```bash
task build
```

### Run the container from docker

```bash
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock <built_image_id> zsh
```

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
