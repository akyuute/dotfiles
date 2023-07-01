#
# ~/.bash_profile
#
#for DOTFILE in `find $HOME/dotfiles/`
#do
  #[[ -f “$DOTFILE” ]] && source “$DOTFILE”
#done

#[[ -f ~/dotfiles/.bashrc ]] && . ~/dotfiles/.bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Append dirs to $PATH
PATH="$PATH:$HOME/bin";
PATH="$PATH:$HOME/scripts";
export PATH

# Bind Alt+Shift+(-)/(+) to change terminal brightness without Xorg
bind -x '"\e_":"brightnessctl s 1%- &> /dev/null"'
bind -x '"\e+":"brightnessctl s 1%+ &> /dev/null"'

