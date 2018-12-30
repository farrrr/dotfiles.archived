cite about-plugin
about-plugin 'Keychain helper functions'

KEYCHAIN_PATH="$(which keychain)"

if [ "$KEYCHAIN_PATH" ]; then
    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -a`
    [[ -f $HOME/.ssh/id_rsa_farrrr ]] && $KEYCHAIN_PATH $HOME/.ssh/id_rsa_farrrr
    [[ -f $HOME/.ssh/id_rsa_github ]] && $KEYCHAIN_PATH $HOME/.ssh/id_rsa_github
    [[ -f $HOME/.keychain/$HOSTNAME-sh ]] && source $HOME/.keychain/$HOSTNAME-sh
fi
