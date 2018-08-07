for file in ~/.bashrc_{config,aliases,functions,prompt,prompt-config,completions,secret}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

[[ -f ~/.bashrc-local ]] && source ~/.bashrc-local
