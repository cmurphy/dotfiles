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
  local git_prompt="$(__git_ps1)"
#  # How much space if all on one line?
  let fillsize=${COLUMNS}-${#left}-${#git_prompt}-3
  local fill=`printf ' %.0s' {1..500}`
  # If one line works, do that
  if [ $fillsize -gt 0 ] ; then
    local fill=${fill:0:$fillsize}
  # Otherwise put it on the next line
  else
    let fillsize=${COLUMNS}-${#git_prompt}-1
    local fill=${fill:0:$fillsize}
    local fill="\n"${fill}
  fi
  if [ -n "$git_prompt" ] ; then
    git_prompt="\[\e[1;35m\]${git_prompt}\[\e[m\]"
  fi

  PS1='\[\e[1;32m\]\u\[\e[m\]\[\e[1;34m\]@\[\e[m\]\[\e[1;36m\]\h:\w \[\e[m\]'
  PS1="$PS1 ${fill} ${git_prompt} ${prompt_symbol}"
}

PROMPT_COMMAND=set_prompt

# Clone openstack projects
function osco() { git clone git://git.openstack.org/openstack/${1}.git $1 ; }
# Clone infra projects
function osico() { git clone git://git.openstack.org/openstack-infra/${1}.git $1 ; }


# Checking out pull requests
function pr() {
  id=$1
  git fetch origin pull/${id}/head:pr_${id}
  git checkout pr_${id}
}

banishvm() {
  vm=$1
  virsh destroy $vm && virsh undefine $vm
}
