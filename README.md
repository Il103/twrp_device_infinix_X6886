# OrangeFox Recovery — Infinix X6886 (MT6789 / Helio G99)

| | |
|---|---|
| **Device** | Infinix X6886 (Note 12 G96) |
| **SoC** | MediaTek Helio G99 (MT6789) |
| **Arch** | arm64 — A/B + VAB |
| **Recovery** | OrangeFox R12.1 (Android 12.1) |
| **Maintainer** | B E R U (@Il103) |

Device tree for building **OrangeFox R12.1** recovery for the Infinix X6886.
Place this tree at `device/infinix/X6886/` in an OrangeFox R12.1 build tree.

## Features

- **Vendor boot image** (header v4) — builds as `vendorbootimage`
- **Auto-decrypt** with lockscreen password (FBE v2 + Metadata Encryption) on boot
- **Format Data** — wipes `/metadata` automatically (no encryption mismatch after format)
- **Flashlight** toggle in status bar
- **Vibrator** feedback support
- **120 Hz / 144 Hz** display refresh support
- **Material You** theme (selectable in Customization → Theme) + dark theme default
- **Gesture / modern navigation** (navbar can be disabled)
- **MTP**, **Fastbootd**, **External SD**, **Brightness** control
- **KernelSU** support, **FRP** addon
- **Settings persistence** across reboots (stored in `/cache`)

## Requirements

- Unlocked bootloader
- OrangeFox R12.1 build tree (Android 12.1)
- Prebuilt kernel + DTB from stock (`TARGET_NO_KERNEL := true`)

## Build

```bash
source build/envsetup.sh
lunch ofox_X6886-eng
export ALLOW_MISSING_DEPENDENCIES=true
m vendorbootimage
```

Output: `out/target/product/X6886/OrangeFox-R12.1-Unofficial-X6886.img`

## Notes

- Flash via fastboot: `fastboot flash vendor_boot out/target/product/X6886/OrangeFox-R12.1-Unofficial-X6886.img`
- On first boot, enter your lockscreen password when prompted to decrypt `/data`.

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
