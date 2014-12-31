export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias rvmgo='source ~/.rvm/scripts/rvm'

set_prompt() {
  RET=$?
  if [ $RET -eq 0 ] ; then
    local prompt_color="\[\e[0;32m"
  else
    local prompt_color="\[\e[0;31m"
  fi
  local prompt_symbol="${prompt_color}\n \$\[\e[m\] "

  local left="`whoami`@`hostname`:`pwd | sed -e "s,$HOME,~,"`"
  local rvm_prompt="$(~/.rvm/bin/rvm-prompt)"
  let fillsize=${COLUMNS}-${#left}-${#rvm_prompt}-5
  local fill=`printf ' %.0s' {1..500}`
  local fill=${fill:0:$fillsize}
  if [ -n "$rvm_prompt" ] ; then
    rvm_prompt="\[\e[0;35m\](${rvm_prompt})\[\e[m\]"
  fi

  PS1='\[\e[1;32m\]\u\[\e[m\]\[\e[1;34m\]@\[\e[m\]\[\e[1;36m\]\h:\w \[\e[m\]'
  PS1="$PS1 ${fill} ${rvm_prompt}${prompt_symbol}"
}

PROMPT_COMMAND=set_prompt

source ~/git-completion.bash

# VCloud (from Hunner https://github.com/hunner/hunners-homedir-configs/blob/master/.zshenv)
function listvm() { curl -s --url http://vcloud.delivery.puppetlabs.net/vm/ ; }
function getvm() { curl -s -d --url http://vcloud.delivery.puppetlabs.net/vm/$1 ; }
function sshvm() { ssh -i ~/.ssh/id_rsa-acceptance root@$1 ; }
function rmvm() { curl -X DELETE --url http://vcloud.delivery.puppetlabs.net/vm/$1 ; }
function sshwin() { ssh -i ~/.ssh/id_rsa-acceptance Administrator@$1 ; }

function vm() {
  search=$1
  vmtype=$(listvm | grep $search | tail -1 | cut -d ',' -f 1 | tr -d '"') # Get newest version if not specified
  echo "Getting ${vmtype}..."
  host=`getvm $vmtype | grep 'hostname' | awk -F ' ' '{print $2}' | tr -d '"'`
  echo "SSHing to ${host}..."
  (sshvm $host)   # Subshell so that the function will continue executing after SSH exits
  echo "Deleting ${host}..."
  rmvm $host
}

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
