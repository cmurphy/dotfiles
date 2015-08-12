# RBenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

__rbenv_ps1 ()
{
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  printf $rbenv_ruby_version
}

#PS1
set_prompt() {
  RET=$?
  if [ $RET -eq 0 ] ; then
    local prompt_color="\[\e[0;32m"
  else
    local prompt_color="\[\e[0;31m"
  fi
  local prompt_symbol="${prompt_color}\n \$\[\e[m\] "

  local left="`whoami`@`hostname`:`pwd | sed -e "s,$HOME,~,"`"
  local rbenv_prompt="\$(__rbenv_ps1)"
#  local rvm_prompt="$(~/.rvm/bin/rvm-prompt)"
#  # How much space if all on one line?
  let fillsize=${COLUMNS}-${#left}-${#rbenv_prompt}-2
  local fill=`printf ' %.0s' {1..500}`
  # If one line works, do that
  if [ $fillsize -gt 0 ] ; then
    local fill=${fill:0:$fillsize}
  # Otherwise put it on the next line
  else
    let fillsize=${COLUMNS}-${#rvm_prompt}-1
    local fill=${fill:0:$fillsize}
    local fill="\n"${fill}
  fi
  if [ -n "$rbenv_prompt" ] ; then
    rbenv_prompt="\[\e[0;35m\](${rbenv_prompt})\[\e[m\]"
  fi

  PS1='\[\e[1;32m\]\u\[\e[m\]\[\e[1;34m\]@\[\e[m\]\[\e[1;36m\]\h:\w \[\e[m\]'
  PS1="$PS1 ${fill} ${rbenv_prompt}${prompt_symbol}"
}

PROMPT_COMMAND=set_prompt

source ~/git-completion.bash

# Cloning puppetlabs modules
function gpmod() { git clone git@github.com:puppetlabs/puppetlabs-${1}.git $1 ; }

# Cloning stackforge modules
function gsmod() { git clone git@github.com:stackforge/puppet-${1}.git $1 ; }

# Checking out pull requests
function pr() {
  id=$1
  git fetch origin pull/${id}/head:pr_${id}
  git checkout pr_${id}
}
