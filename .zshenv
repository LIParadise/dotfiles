(( $+commands[vim] )) && export EDITOR=vim
(( $+commands[vim] )) && export VISUAL=vim
(( $+commands[less] )) && export PAGER=less
export COLUMNS  # Remember columns for subprocesses.
# This may break some apps, like Dropbox device linking? Get url from ps.
if (( $+DISPLAY )); then
	export BROWSER=xdg-open
else
	(( $+commands[w3m] )) && export BROWSER=w3m || export BROWSER=elinks
fi
