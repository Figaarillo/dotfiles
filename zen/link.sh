#!/usr/bin/env bash
# Symlinks user.js into Zen's default profile. Profile folders have random names, so stow can't target them.
set -euo pipefail

HERE=$(dirname "$(readlink -f "$0")")
INI="$HOME/.zen/profiles.ini"
[[ -f $INI ]] || { echo "No existe $INI: abrí Zen una vez para que cree el perfil."; exit 1; }

profile=""
in_install=0
while IFS= read -r line; do
  case $line in
    \[Install*\]) in_install=1 ;;
    \[*\])        in_install=0 ;;
    Default=*)    (( in_install )) && { profile=${line#Default=}; break; } ;;
  esac
done < "$INI"

[[ -n $profile ]] || { echo "No encontré el perfil por defecto en $INI."; exit 1; }
dst="$HOME/.zen/$profile/user.js"

if [[ -e $dst && ! -L $dst ]]; then
  mv "$dst" "$dst.bak"
  echo "Había un user.js propio: lo moví a $dst.bak"
fi
ln -sfn "$HERE/user.js" "$dst"
echo "OK: $dst -> $HERE/user.js"
echo "Reiniciá Zen para aplicarlo."
