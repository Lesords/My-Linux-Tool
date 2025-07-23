# Introduction

This repository records some useful linux tools, as shown below

- bat
- ctags
- diff-so-fancy
- lazygit
- rg
- tokei
- joshuto
- icdiff
- delta
- fzf
- clangd
- bear
- ttyper
- fd
- hexyl
- btop
- fastfetch
- hyperfine
- filebrowser

Tools required to compile

- gtags
- tig
- vifm

# Usage

First you need to clone the repository.

```bash
git clone git@github.com:Lesords/My-Linux-Tool.git --depth=1
# Or
git clone https://github.com/Lesords/My-Linux-Tool.git --depth=1

cd My-Linux-Tool
```

Then use the following command to download all tools.

```bash
./generate

# Generate all tools including those required for compilation
./generate -a
# Or
./generate --all

# Download the arm version of the tool
./generate --arm
# Or
./generate --arm64
```

Finally, use the following command to move all tools to `"$HOME/.local/bin"`.

```bash
./install
```
