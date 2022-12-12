# Tyra's .zshrc
# WIP
source $HOME/.zshfiles/aliases
source $HOME/.zshfiles/vars
source $HOME/.zshfiles/functions
source $HOME/.zshfiles/exports

# History 
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# !! Contents within this block are managed by 'conda init' !!
# TODO: I really should parametrize this path 
__conda_setup="$('/Users/FUBAR/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/FUBAR/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/FUBAR/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/FUBAR/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda ...ENVS)
# DEFINING COLORS AND PROPMT WITH GIT
autoload -U colors && colors
autoload -Uz vcs_info

precmd() {
    # As always first run the system so everything is setup correctly.
    vcs_info
    zstyle ':vcs_info:git:*' formats '[%b]'
    # colors: https://medium.com/@dpeachesdev/intro-to-zsh-without-oh-my-zsh-part-1-c039de5ee22e
    # And then just set PS1, RPS1 and whatever you want to. This $PS1
    # is (as with the other examples above too) just an example of a very
    # basic single-line prompt. See "man zshmisc" for details on how to
    # make this less readable. :-)
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # vcs_info found something (the documentation got that backwards
        # STATUS line taken from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            PS1="%F{131}($CONDA_DEFAULT_ENV)%{$reset_color%} %F{141}%n%{$reset_color%}@%F{130}%m:%F{069}%~%{$reset_color%} %F{132}${vcs_info_msg_0_}%{$reset_color%}\$ "
        else
            PS1="%F{131}($CONDA_DEFAULT_ENV)%{$reset_color%} %F{141}%n%{$reset_color%}@%F{130}%m:%F{069}%~%{$reset_color%} %F{156}${vcs_info_msg_0_}%{$reset_color%}\$ "
        fi

    else
        PS1="%F{131}($CONDA_DEFAULT_ENV)%{$reset_color%} %F{141}%n%{$reset_color%}@%F{130}%m:%F{069}%~%{$reset_color%}\$ "
    fi
}
#End of config