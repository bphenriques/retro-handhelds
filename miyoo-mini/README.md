# Miyoo Mini V4 (with RTC)

Reserved to some platforms, therefore the scripts do not support all compatible platforms.

## Installation:
1. Follow [OnionOS Installation](https://onionui.github.io/docs/installation). TLDR: Format as FAT32 and copy files inside.
2. Create an account in https://screenscraper.fr/ and export the credentials:

```shell
echo "PLATFORM_LOGIN=username:password" > .env.private
```

4. Adjust `.env` to your needs. Set `EXTRA_FILES` to copy files to the root of `OUTPUT_DIR`.
5. Run the following:
```shell
OUTPUT_DIR=/run/media/bphenriques/12CE-A600 sync.sh
```

## Post Install

1. Set the time and disable time advance in settings
2. Install required packages to make the emulators show up in the menu.
3. For Arcade, install regular Arcade and FBNeo. Then you will need to enable per-game.
4. Set the overlays/core options as desired. It can be automated (let's not go that way):
   1. [GB](./GB.md)
   2. [GBC](./GBC.md)
   3. [GBA](./GBA.md)

# Reference and acknowledgments

- Scrapping guide: https://onionui.github.io/docs/advanced/scraping
- Cosy Theme: https://github.com/KyleBing/onion-theme-cosy/releases/download/v2.1/Cosy.by.KyleBing.zip
- Overlays. Not provided to avoid licence issues. Please check:
    - [`ozboss`](https://www.reddit.com/r/MiyooMini/comments/1gcp8oe/miyoo_mini_v4_overlays/).
    - [`berickphilip`](https://github.com/berickphilip/GBA_MiyooV4_Overlay/tree/main).
    - [`drkhrse`](https://github.com/drkhrse/drkhrse_miyoo_bezels).
