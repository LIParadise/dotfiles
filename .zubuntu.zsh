alias dpl='dpkg -L'
bin () { dpkg -L $* | grep bin/ }
nls () { apt-cache search $* | grep -v lib\* }

