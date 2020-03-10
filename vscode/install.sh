printf '\n\e[34;1m%s\e[0m\n\n' "--------VSCode Installation--------" 1>&2

printf '\e[34m%s\e[0m\n' "Installing Visual Studio Code Insiders..." 1>&2
if [ "$MACHINE" = "Ubuntu" ] && [ "$UI_TYPE" != "headless" ]; then
    snap install --classic code-insiders
elif [ "$MACHINE" = "MacOS" ] && [ "$UI_TYPE" != "headless" ]; then
    brew tap homebrew/cask-versions
    brew cask install visual-studio-code-insiders
else
    printf '\e[31m%s\e[0m\n' "Visual Studio Code Insiders not installed..." 1>&2
fi
