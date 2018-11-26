# F1-12: https://github.com/vmalloc/zsh-config/blob/master/extras/function_keys.zsh
fnKeys=('^[OP' '^[OQ' '^[OR' '^[OS' '^[[15~' '^[[17~' '^[[18~' '^[[19~' '^[[20~' '^[[21~' '^[[23~' '^[[24~', '^[[25~', '^[[26~', '^[[27~', '^[[28~', '^[[29~', '^[[30~', '^[[31~', '^[[32~', '^[[33~', '^[[34~', '^[[35~', '^[[36~')
touchBarState=''
npmScripts=()
lastPackageJsonPath=''
useYarn=false

function _clearTouchbar() {
  # echo -ne "\033]1337;PopKeyLabels\a"
  echo -ne "\033]1337;SetKeyLabel=F1=           No package.json in 🗂                                                 \a"
}

function _unbindTouchbar() {
  for fnKey in "$fnKeys[@]"; do
    bindkey -s "$fnKey" ''
  done
}

function _displayDefault() {
  _clearTouchbar
  _unbindTouchbar

  touchBarState=''

  # PACKAGE.JSON
  # ------------
  if [[ -f package.json ]]; then
    _displayNpmScripts
  fi
}

function _displayNpmScripts() {
  # find available npm run scripts only if new directory
  if [[ $lastPackageJsonPath != $(echo "$(pwd)/package.json") ]]; then
    lastPackageJsonPath=$(echo "$(pwd)/package.json")
    npmScripts=($(node -e "console.log(Object.keys($(npm run --json)).filter((name, idx) => idx < 24).join(' '))")) 
  fi

  if [[ $npmScripts == "" ]]; then
    _clearTouchbar
  else
    _clearTouchbar
    _unbindTouchbar

    touchBarState='npm'

    fnKeysIndex=1
    for npmScript in "$npmScripts[@]"; do
      if [[ $useYarn == true ]]; then
      bindkey -s $fnKeys[$fnKeysIndex] "yarn $npmScript \n"
      else
        bindkey -s $fnKeys[$fnKeysIndex] "npm run $npmScript \n"
      fi
      echo -ne "\033]1337;SetKeyLabel=F$fnKeysIndex=👉🏻 $npmScript\a"
      fnKeysIndex=$((fnKeysIndex + 1))
    done

    for fnKey in "$fnKeys[@]"; do
      echo -ne "\033]1337;SetKeyLabel=F$fnKeysIndex=✕\a"
      fnKeysIndex=$((fnKeysIndex + 1))
    done
  fi
}

zle -N _displayDefault
zle -N _displayNpmScripts

precmd() {
  if [[ $touchBarState == 'npm' ]]; then
    _displayNpmScripts
  else
    _displayDefault
  fi
}
