# dotfiles

## Installation/Bootstrapping


If on a fresh environment, specifically without git
```bash
sh <(curl -fsS https://raw.githubusercontent.com/jetpackjarrett/dotfiles/master/bootstrap.sh)
```

If git is already setup
```bash
git clone https://github.com/jetpackjarrett/dotfiles.git ~/.dotfiles
sh setup.sh
```

## Usage

Re-run all setup tasks
```bash
sh setup.sh
```

Link just dotfiles
```bash
sh setup/dotfiles.sh
```


Feel free to fork and use however you want. Several portions are probably only usable if you are an OSX user. Probably also want to change gitconfig in your fork to your information.
