# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

export FZF_DEFAULT_COMMAND="rg --files"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ] && source /usr/local/opt/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

rga-fzf() {
RG_PREFIX="rga --files-with-matches"
local file
file="$(
FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
  fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
  --phony -q "$1" \
  --bind "change:reload:$RG_PREFIX {q}" \
  --preview-window="70%:wrap"
  )" &&
    echo "opening $file" &&
    xdg-open "$file"
  }
