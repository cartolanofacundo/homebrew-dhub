# Homebrew Tap for dhub

This repository contains Homebrew formulas for installing [dhub](https://github.com/fcartolano/dhub) and related tools.

## What is dhub?

**Directory Hub (dhub)** is a command-line tool that helps you quickly navigate to your frequently used directories using custom aliases. Never type long directory paths again!

## Requirements

- **macOS** (Intel or Apple Silicon)
- **Homebrew** package manager

## Available Formulas

| Formula | Description |
|---------|-------------|
| `dhub`  | Directory Hub - Quick directory navigation tool |

## Installation

### Install dhub

```bash
# Add this tap to your Homebrew
brew tap fcartolano/dhub

# Install dhub
brew install dhub
```

### Start using dhub

After installation, you need to source your shell configuration file to start using dhub:

```bash
# For Bash users
source ~/.bash_profile

# For Zsh users
source ~/.zshrc
```

## Usage Examples

### Adding Directory Aliases

```bash
# Add current directory with alias 'myproject'
dhub add myproject

# Add specific directory with alias 'tools'
dhub add tools /usr/local/bin
```

### Navigating to Aliased Directories

```bash
# Navigate to 'myproject' directory
dhub goto myproject
```

## Contributing

If you encounter any issues or have suggestions for improvements, please file an issue at the [dhub repository](https://github.com/fcartolano/dhub/issues).

## License

This project is licensed under the MIT License.

