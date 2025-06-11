# Retro Handhelds

Holds some utility scripts to manage my retro handhelds devices. Feel free to adapt to your use-case, they are not 
perfect, but I had to draw a line to stop tinkering and actually start enjoying the games :)

# Pre-Requirements

If you are using `direnv` and `nix flake`, you can use `direnv allow`.

Alternatively install skyscraper (see version according to `shell.nix`).

# Install

My file structure:
```declarative
/mnt/nas-media/gaming/Emulation
├── bios
│   ├── ...
│   ...
├── dats
│   ├── ...
|   ...
├── roms
│   ├── doom
│   ├── dos
│   ├── dreamcast
│   ├── fbneo
│   ├── gb
│   ├── gba
│   ├── gbc
│   ├── gc
│   ├── megadrive
│   ├── n64
│   ├── nds
│   ├── nes
│   ├── pico8
│   ├── ps2
│   ├── ps3
│   ├── psp
│   ├── psx
│   ├── snes
│   └── ...
...

38 directories, 195 files
```

Depending on the platform, I also have the folders `patches` or `modern`. 

I keep both pre-patches and patched ROMs as I don't want to go onto the effort of setting up [igir](https://igir.io/) to patch the games on-the-fly to a target folder. Plus, it would make it harder to sync (I use [syncthing](https://syncthing.net/)).

## Miyoo Mini V4 (with RTC)

Reserved to some platforms, therefore I am not setting up for NDS, nor PSX.

1. Follow [OnionOS Installation](https://onionui.github.io/docs/installation). TLDR: Format as FAT32 and copy files inside.
2. Create an account in https://screenscraper.fr/ and export the credentials:
```
$ cd miyoo-mini
$ echo "PLATFORM_LOGIN=username:password" > .env.private
```
3. Adjust `.env` to your needs. 
4. Run the following:
```shell
$ cd miyoo-mini
$ OUTPUT_DIR=/run/media/bphenriques/12CE-A600 sync.sh
```
5. Disable time advance in settings
6. Install required packages to make the emulators show up in the menu.

You can set `EXTRA_FILES` to copy files to the root of `OUTPUT_DIR` (files you don't want to track publicly).

# Reference and acknowledgments

- Miyoo Mini:
  - Scrapping guide: https://onionui.github.io/docs/advanced/scraping
  - Cosy Theme: https://github.com/KyleBing/onion-theme-cosy/releases/download/v2.1/Cosy.by.KyleBing.zip

# License

Only covers the shell script.