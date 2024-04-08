PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg_bold[red]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
PROMPT+='$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[214]%}git:(%{$FG[226]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[214]%}) %{$FG[226]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[214]%})"
