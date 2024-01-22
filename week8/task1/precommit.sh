#!/bin/bash

ARGUMENTS="$*"
GL_BASEPATH="https://github.com/gitleaks/gitleaks/releases/download"
GL_VERSION="8.18.1"
TMPDIR="./gitleaks_temp" 

DETECTED_OS=$(uname)
case "$DETECTED_OS" in
  Darwin*|darwin*)      OS="darwin" && FILEEXT="tar.gz" && UNPACKER="tar -xz" ;;
  Linux*|linux*)        OS="linux" && FILEEXT="tar.gz" && UNPACKER="tar -xz" ;;
  Windows*|windows*)    OS="windows" && FILEEXT="zip" && UNPACKER="unzip" ;;
  Cygwin*|cygwin*)      OS="windows" && FILEEXT="zip" && UNPACKER="unzip" ;;
  *)                    OS="unknown" ;;
esac

DETECTED_ARCH=$(uname -m)
case "$DETECTED_ARCH" in
  x86_64*|X86_64|amd64|AMD64*)  ARCH="x64" ;; 
  arm64*|ARM64*)                ARCH="arm64" ;; 
  *)                            ARCH="unknown" ;; # we wll not support any other arch like armv6, armv7
esac

GITLEAKS_PKG="$GL_BASEPATH/v$GL_VERSION/gitleaks_$GL_VERSION"_"$OS"_"$ARCH.$FILEEXT"

echo OS = $OS
echo ARCH = $ARCH
echo GitLeaks = $GITLEAKS_PKG
echo Arguments/Parameters = $ARGUMENTS

if [[ "$ARGUMENTS" == "" ]]; then
  echo "Nothing to do, will exit."
  echo "Use with theese parameters, please (parameters can be combined):"
  echo "  install - will install pre-commit and gitleaks."
  echo "  setup-globally - will setup it for all repositories, which will be cloned in the future."
  echo "  setup-here - will setup only this repository (need to be in the root repository)."
  echo "  check-here - will checking this repository with gitleaks and pre-commit (need to be in the root repository and pre-commit and gitleaks need to be installed)."
  exit
fi

if [[ "$OS" == "darwin" || "$OS" == "linux" ]]; then

# install pre-commit and gitleaks
  if [[ $ARGUMENTS =~ "install" ]]; then
    echo "Installing pre-commit and gitleaks..."
    mkdir $TMPDIR
    curl -sL $GITLEAKS_PKG | $UNPACKER -C $TMPDIR
    if [[ "$OS" == "darwin" ]]; then cp $TMPDIR/gitleaks $HOME/bin; fi
    if [[ "$OS" == "linux" ]]; then cp $TMPDIR/gitleaks $HOME/.local/bin; fi
    rm -rf $TMPDIR
    git config --global gitleaks.enable true
    pip install pre-commit
  fi

# setup pre-commit for all repositories which will be cloned in the future
  if [[ $ARGUMENTS =~ "setup-global" ]]; then
    echo "Doing setup globally..."
    git config --global init.templateDir ~/.git-template
    pre-commit init-templatedir ~/.git-template
  fi

# setup pre-commit and gitleaks for the this repository
  if [[ $ARGUMENTS =~ "setup-here" ]]; then
    if [[ -e ".git" ]]; then
      echo "Doing setup for this repository only..."
      pre-commit install
      git config gitleaks.enable true
      cat <<EOF >.pre-commit-config.yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v$GL_VERSION
    hooks:
      - id: gitleaks
EOF
    else
      echo "Directory .git not found here. Need to be in the root of repository. No action"
    fi
  fi

  if [[ $ARGUMENTS =~ "check-here" ]]; then
    echo "Doing check for this repository only..."
    gitleaks detect -v
    pre-commit
  fi

elif [[ "$OS" = "windows" ]]; then

  echo "Windows block not inmplemented yet. But this is can be similar to Linux/OSX implementation"

else

  echo "Unsupported platform detected. No actions."

fi
