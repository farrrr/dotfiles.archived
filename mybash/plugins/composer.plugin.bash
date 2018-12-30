cite about-plugin
about-plugin 'Composer helper functions'

# Make sure the composer prefix is on the path
[[ `which composer` ]] && pathmunge $HOME/.composer/vendor/bin
