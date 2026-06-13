# npmx

Interactive npm script runner for Zsh. Lists scripts from `package.json` and runs the one you pick with [fzf](https://github.com/junegunn/fzf).

## Requirements

- Zsh
- [jq](https://stedolan.github.io/jq/)
- [fzf](https://github.com/junegunn/fzf)

## Usage

From a project directory that contains `package.json`:

```sh
npmx          # open fzf picker and run selected script
npmx list     # print all available scripts
```

## Install

### Homebrew

```sh
brew tap wxwvx/npmx https://github.com/wxwvx/npmx
brew trust wxwvx/npmx
brew install npmx
```

### Manual

```sh
curl -fsSL https://raw.githubusercontent.com/wxwvx/npmx/v0.1.0/npmx.sh -o ~/.local/bin/npmx
chmod +x ~/.local/bin/npmx
```

Ensure `~/.local/bin` is on your `PATH`.
