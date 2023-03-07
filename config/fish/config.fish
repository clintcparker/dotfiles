if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish                     
	source /opt/homebrew/opt/asdf/libexec/asdf.fish
else
	if test -e /usr/local/opt/asdf/libexec/asdf.fish
		source /usr/local/opt/asdf/libexec/asdf.fish
	else
		source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
	end
end

direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow

starship init fish | source
thefuck --alias | source 

alias ss1-up='ssh  -fNTM ss1'
alias ss1-status='ssh -TO check ss1'
alias ss1-down='ssh -TO exit ss1'
