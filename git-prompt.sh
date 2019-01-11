if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;Git Bash Command Prompt\007\]' # set window title
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[0;35m\]'     # change to purple
	PS1="$PS1"'\W'                 # current working directory
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[1;34m\]'  # change color to blue
			PS1="$PS1"'`__git_ps1`'     # bash function
		fi
	fi
	PS1="$PS1"'\[\033[33m\]'       # change color to yellow
	PS1="$PS1"' ➜ '               # prompt: ->
	PS1="$PS1"'\[\033[0m\]'        # change color to gray
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
