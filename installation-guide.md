# Guia de instalcion para Hyprland

## Instalacion de dependencias


## Dependencias basicas

**android mount pkgs**
- `mtpfs`: for media transfer protocol
`jmtpfs`: for later version supports
`gvfs-mtp`: for automount and all ( usb android file transfer )
`gvfs-gphoto2`: for picture transfer protocol

```bash
sudo pacman -Syy \
base-devel \
mtpfs \
gvfs gvfs-mtp gvfs-gphoto2 \
gnome-keyring \
jq unzip unrar \
blueman bluez bluez-utils \
zsh
```


## Dependencias necesarias

- `wayland-protocols`: Specifications of extended Wayland protocols

```bash
yay -S base-devel \
hyprland-git xdg-desktop-portal-hyprland-git wayland-protocols \
waybar-hyprland wlogout wofi \
hyprpicker wl-clipboard swww swaync swaylock-effects-git grim \
qt5-base qt5-wayland qt6-base qt6-wayland qt5ct qt6ct polkit-gnome \
pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber \
playerctl pavucontrol mpd mpd-mpris \
yad blueman network-manager-applet libinput-gestures wayland-protocols \
cava kitty starship tty-clock-git btop lsd geany bat cliphist \
geany \
boo-grub-git sddm-git boo-sddm-git proxzima-plymouth-git \
--needed
```

## Dependencias extras

- `tumbler`: Thumbnail service implementing the thumbnail management D-Bus specification


```bash
yay -S \
xdg-user-dirs xdg-utils \
system76-power \
obs-studio wlrobs-hg v4l2loopback-dkms v4l2loopback-utils v4l-utils \
thunar thunar-archive-plugin thunar-shares-plugin thunar-volman \
discord spotify telegram-desktop\
qalculate-gtk qimgv-light \
uget tldr \
tumbler tumbler-extra-thumbnailers \
spicetify-cli \
--needed
```

```bash
nemo gamemode g4music visual-studio-code-bin light chromium-wayland-vaapi libreoffice-fresh rlr-git bulky waydroid binder_linux-dkms \
```

## Fonts, GTK Themes, Icons, Mouse, GRUB, Plymouth & SDDM

### Fonts
sudo pacman -S $(pacman -Ssq ttf-victor && pacman -Ssq tff-cascadia) ttf-fira-code ttf-firacode-nerd
```bash
sudo pacman -S \
adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts \
cantarell-fonts \
noto-fonts noto-fonts-cjk noto-fonts-emoji \ 
ttf-cascadia-code ttf-cascadia-code-nerd \
ttf-dejavu \
$(pacman -Ssq ttf-fira) \
ttf-font-awesome \
ttf-hack \
ttf-iosevka-nerd \
ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
ttf-liberation \
ttf-nerd-fonts-symbols-mono \
ttf-opensans \
ttf-roboto \
ttf-victor-mono-nerd
```

```bash
ttf-twemoji-color \
yay -S \
ttf-maple \
$(yay -Ssq operator-mono)
```

#### Actualizar cache de las fuentes

Una vez se halland descargado todas las fuentes, corre el siguiente comando para que tu sistema detecte las nuevas fuentes instaladas

```bash
fc-cache -fv
```

### GTK Theme

```bash
cd ~/Downloads
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
cd Tokyo-Night-GTK-Theme/
sudo cp -r themes/Tokyonight-Dark-BL-LB /usr/share/themes/
```

### Icons

```bash
cd ~/Downloads
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
cd Tokyo-Night-GTK-Theme/
sudo cp -r icons/Tokyonight-Moon /usr/share/icons/
```

### Mouse

```bash
cd ~/Downloads
git clone https://github.com/EliverLara/Sweet.git -b nova
cd Sweet/
sudo cp -r kde/cursors/Sweet-cursors /usr/share/icons/
```

### GRUB

1. Edit grub config file

```bash
$ sudo vim /etc/default/grub
```

change `#GRUB_THEME=` to `GRUB_THEME="/usr/share/grub/themes/boo/theme.txt"`

2. Update grub using

```bash
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```

3. Reboot and voila

### Plymouth


```bash
# check if theme exist in dir
sudo plymouth-set-default-theme -l

# optionally you can test the theme by running the script given in repo (plymouth-x11 required)
sudo ./preview.sh 13

# now set the theme (proxzima, in this case) and rebuilt the initrd
sudo plymouth-set-default-theme -R proxzima
```

If you want to use the shutdown animation as boot screen then do the following changes in the `proxzima.script` file.

```diff
- boot = 196;
+ boot = 97;

-   flyingman_image[i] = Image("boot-" + i + ".png");
+   flyingman_image[i] = Image("shut-" + i + ".png");
```

### SDDM


1. Edit sddm config file

```bash
$ sudo vim /etc/sddm.conf
```

Make the following changes

```conf
[Theme]
Current=boo
```

2. Reboot and voila


## Dotfiles

```bash
cd ~/Downloads
git clone https://github.com/PROxZIMA/.dotfiles.git
cd .dotfiles
# cp -r .config .icons .local .mpd .ncmpcpp .scripts ~/
# cp -r .config .mpd .ncmpcpp .scripts ~/
cp .face .fonts.conf .dmrc .gtkrc-2.0 ~/
chmod -R +x ~/.scripts/
chmod +x ~/.config/hypr/autostart
chmod -R +x ~/.config/wlogout/
```

## Services

### Bluetooh
