[[ -n ${commands[vimdiff]} ]] && export DIFFPROG=vimdiff # pacdiff

alias p='pacui'
alias pm='sudo pacmatic'
alias pmr='sudo pacmatic -R' # Pacman remove
alias pmc='sudo pacmatic -Sc' # Clean cache
alias pmrc='sudo pacmatic -Rns' # Pacman remove w/config
alias pms='pacmatic -Ss' # Pacman search
alias pmls='pacmatic -Qs' # Local search
alias pmu='sudo pacmatic -Syu' # Pacman upgrade
alias pml='pacmatic -Ql' # List (files)
alias pmo='pacmatic -Qqtd' # Orphans
alias pa='pacaur'
alias pau='pacaur -Syu' # Pacaur upgrade
alias pas='pacaur -Ss' # Pacaur search
alias par='pacaur -R' # Pacaur remove
alias pac='pacaur -Sc' # Pacaur clean cache
alias parc='pacaur -Rns' # Pacaur remove w/config
alias orphans='pacmatic -Qdt'
alias paclog='egrep "pac(new|save)" /var/log/pacman.log'
alias lpac='locate --existing --regex "\.pac(new|save)$"'
alias mk='makepkg'
alias mks='makepkg -s'
alias mki='makepkg -is'
bin () { pacmatic -Ql $* | grep --color=auto bin/ | awk '{print $2}' } # binaries from package
#bin () { pkgfile -l $* | grep --color=auto bin/ }
owns () { pacmatic -Qo $(which $*) } # Ownership of binary

NOTFOUND="/usr/share/doc/pkgfile/command-not-found.zsh"
[[ -f $NOTFOUND ]] && source $NOTFOUND
