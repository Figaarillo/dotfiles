# Arch maintenance notes

Real breakages from this machine and how they were fixed. Check here before fighting an update.

## Quick path: an update fails

1. **Is the failing package from AUR?** `pacman -Si <pkg>` → `was not found` means AUR.
2. **Do you need it?** `pacman -Qi <pkg>` → look at `Required By` and `Optional For`.
3. **Not needed** → remove it. **Needed** → find it in the table below.

## Known problems

| Symptom | Cause | Fix |
|---------|-------|-----|
| `installing audit (X) breaks dependency 'audit=Y' required by lib32-audit` | `lib32-audit` (AUR) pins the exact `audit` version. `yay` upgrades repo packages *before* building AUR ones, so it deadlocks. | See [lib32-audit deadlock](#lib32-audit-deadlock). |
| A build runs for hours (`[2968/24206] g++ ...`) | The package compiles Chromium: `qt5-webengine`, `electronNN`. | Check `Required By`. Remove it, or switch to a `-bin` package (e.g. `bruno-bin` instead of `bruno-git`). |
| `wlroots0.18` fails: `LIBINPUT_SWITCH_KEYPAD_SLIDE not handled [-Werror=switch]` | Old wlroots vs new libinput. Only `wlrobs-hg` needs it. | Don't install `wlrobs-hg`. In OBS use the **Screen Capture (PipeWire)** source. |
| `savedesktop` fails in `check()` (appstream validation) | Stricter `appstreamcli`. Metadata lint only. | `yay -S savedesktop --mflags "--nocheck"` |
| `swaync.service` failed: `An instance ... is already running` | Started twice: from Hyprland autostart *and* by D-Bus activation. | Never start `swaync` in `autostart`. D-Bus starts it through systemd. Don't install `dunst`: it competes for `org.freedesktop.Notifications`. |
| Boot hangs ~90 s, `Timed out waiting for device /dev/tpm0` | Firmware announces a TPM that the kernel doesn't expose. | Add `systemd.tpm2_wait=0` to `GRUB_CMDLINE_LINUX_DEFAULT`, then `sudo grub-mkconfig -o /boot/grub/grub.cfg`. Fixed by kernel 7.2.11 on this laptop; may come back on other hardware. |
| `yay` warns `Packages not in AUR` / `Orphan` | Package dropped or unmaintained. | Look for a repo replacement with `pacman -Ss`. Done so far: `mpd-mpris-bin` → `mpd-mpris`, `nodejs-lts-iron` → `nodejs-lts-krypton`. |

### lib32-audit deadlock

Build the new `lib32-audit` first, then install it with `pacman -U`: that pulls the matching `audit` in the **same** transaction.

```sh
yay -G lib32-audit && cd lib32-audit      # or: cd ~/.cache/yay/lib32-audit && git pull
makepkg -d -f                             # -d: skip the dep check that causes the deadlock
sudo pacman -U lib32-audit-<version>-x86_64.pkg.tar.zst
yay -Syu
```

### Slow boot: how to find the culprit

`systemd-analyze blame` hides waits on devices. Use:

```sh
systemd-analyze critical-chain
```

## .pacnew files

Never copy a `.pacnew` over the original without reading the diff. Use `sudo DIFFPROG="nvim -d" pacdiff`.

| File | Action |
|------|--------|
| `pacman.conf` | Merge by hand. The `.pacnew` drops `[multilib]` and the MEGA repo. |
| `mkinitcpio.conf` | Keep yours. The `.pacnew` drops the `btrfs` module and the `plymouth` hook. |
| `pacman.d/mirrorlist` | Keep yours. `reflector` manages it. |
| `locale.gen` | Keep yours. |
| `makepkg.conf.d/*.conf`, `tpm2-tss/fapi-profiles/*` | Take the `.pacnew`. |

After merging, copy the result into `system/etc/` so the repo stays in sync.

## Routine maintenance

Automatic (enabled by `system/install.sh`):

- `paccache.timer`: trims the pacman cache weekly.
- `reflector.timer`: refreshes the fastest mirrors (AR, BR, CL, US).
- Journal capped at 500 MB.

Manual, after a successful update:

```sh
pacman -Qdtq | sudo pacman -Rns -   # orphans
rm -rf ~/.cache/yay/*               # AUR build cache (can reach 10 GB+)
docker builder prune -f             # Docker build cache
```

## Gotchas

- `/tmp` lives in RAM: anything there disappears on reboot. Don't keep scripts there.
- Run `sudo` commands in a real terminal: tools without a TTY can't ask for the password.
- Node: the system `nodejs-lts-krypton` exists for `npm`/`asar`. Projects use **Volta** (`~/.volta/bin` wins in `PATH`).
