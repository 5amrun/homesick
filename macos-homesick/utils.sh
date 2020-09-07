
echo "Loading source: utils.sh"


function print_in_box()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 11
  echo " -${b//?/-}-
| ${b//?/ } |"
  for l in "${s[@]}"; do
    printf '| %s%*s%s |\n' "$(tput setaf 6)" "-$w" "$l" "$(tput setaf 11)"
  done
  echo "| ${b//?/ } |
 -${b//?/-}-"
  tput sgr 0
}



