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

# License

Only covers the shell script.