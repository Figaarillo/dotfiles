#!/usr/bin/env bash
# Applies the /etc part of these dotfiles. Safe to re-run: every overwritten file is backed up first.
set -euo pipefail

[[ $EUID -eq 0 ]] || { echo "Correlo con sudo: sudo $0"; exit 1; }
if [[ -e /var/lib/pacman/db.lck ]]; then
  echo "pacman está corriendo (o quedó un lock). Esperá a que termine."
  exit 1
fi

SRC="$(dirname "$(readlink -f "$0")")/etc"
BK="/root/dotfiles-system-backup-$(date +%Y%m%d-%H%M%S)"
ROOT_FS=$(findmnt -no FSTYPE /)

warn() { printf '  ! %s\n' "$*"; }

put() {
  local rel=$1 dst="/etc/$1"
  if [[ -e $dst ]]; then
    mkdir -p "$BK/$(dirname "$rel")"
    cp -a "$dst" "$BK/$rel"
  fi
  install -Dm644 "$SRC/$rel" "$dst"
  echo "  $dst"
}

echo ">> Backups en $BK"

echo "== pacman =="
mega_block=""
if [[ -f /etc/pacman.conf && $(< /etc/pacman.conf) == *"###REPO for MEGA###"* ]]; then
  mega_block=$(awk '/###REPO for MEGA###/,/###END REPO for MEGA###/' /etc/pacman.conf)
fi
put pacman.conf
if [[ -n $mega_block ]]; then
  printf '%s\n' "$mega_block" >> /etc/pacman.conf
  echo "  (se conservó el repo de MEGA)"
fi
pacman -Syu --needed pacman-contrib reflector zram-generator

echo "== makepkg =="
put makepkg.conf.d/nodebug.conf
printf 'MAKEFLAGS="-j%s"\n' "$(nproc)" > /etc/makepkg.conf.d/makeflags.conf
echo "  /etc/makepkg.conf.d/makeflags.conf (-j$(nproc))"

echo "== memoria (zram) =="
put systemd/zram-generator.conf
put sysctl.d/99-vm-zram.conf
sysctl --system >/dev/null

echo "== journal =="
put systemd/journald.conf.d/size.conf
systemctl restart systemd-journald

echo "== mirrors =="
put xdg/reflector/reflector.conf
systemctl enable reflector.timer
systemctl start reflector.service

echo "== servicios =="
systemctl enable --now systemd-oomd.service paccache.timer
systemctl disable NetworkManager-wait-online.service

echo "== boot (initramfs + GRUB) =="
if [[ $ROOT_FS != btrfs ]]; then
  warn "La raíz es $ROOT_FS, no btrfs: salteo mkinitcpio.conf y grub (los dos asumen btrfs)."
else
  if [[ -e /usr/lib/initcpio/install/plymouth ]]; then
    put mkinitcpio.conf
    mkinitcpio -P
  else
    warn "plymouth no está instalado: salteo mkinitcpio.conf (instalá plymouth y proxzima-plymouth-git primero)."
  fi
  if command -v grub-mkconfig >/dev/null; then
    put default/grub
    [[ -e /usr/share/grub/themes/boo/theme.txt ]] || warn "Falta el tema boo de GRUB (yay -S boo-grub-git). GRUB va a usar el tema por defecto."
    grub-mkconfig -o /boot/grub/grub.cfg
  else
    warn "GRUB no está instalado: salteo /etc/default/grub."
  fi
fi

echo ">> Listo. Reiniciá para aplicar zram y el boot. Backups en $BK"
