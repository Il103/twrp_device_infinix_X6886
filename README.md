# OrangeFox R12.1 Recovery for Infinix X6886

| | |
|---|---|
| **Device** | Infinix X6886 |
| **SoC** | MediaTek Helio G99 (MT6789) |
| **Arch** | arm64 (A/B + VAB) |
| **Recovery** | OrangeFox R12.1 |
| **Maintainer** | B E R U (@Il103) |

## Features ✨

- **Vendor boot image** (header v4)
- **Auto-decrypt** with lockscreen password (FBE v2 + Metadata Encryption)
- **Auto-boot to system** after 5 seconds
- **MTP** enabled
- **Fastbootd** support
- **Flashlight** toggle in status bar
- **120Hz/144Hz** display modes
- **Dark theme** (default)
- **Gesture navigation** (configurable)
- **Vibrator** support
- **KernelSU** support
- **FRP** addon
- **Brightness** control (max 255)
- **External SD** card support
- **Settings persistence** across reboots (stored in `/cache`)

## Requirements

- Unlocked bootloader
- OrangeFox R12.1 or higher build tree
- AOSP/LineageOS 12.1 (Android 12)

## Build Notes

- Uses prebuilt kernel (`TARGET_NO_KERNEL := true`)
- Prebuilt DTB from stock boot image
- Builds as `vendor_boot` image (header version 4)

## Installation

### From existing recovery
```
flash OrangeFox-R12.0-Unofficial-X6886.zip via SD card or OTG
```

### From fastboot
```
fastboot flash vendor_boot OrangeFox-R12.0-Unofficial-X6886.img
fastboot reboot
```

## Build locally

```bash
source build/envsetup.sh
lunch ofox_X6886-eng
export ALLOW_MISSING_DEPENDENCIES=true
m vendorbootimage
```

Output: `out/target/product/X6886/OrangeFox-R12.0-Unofficial-X6886.img`

## Downloads

Check the [Releases](https://github.com/Il103/OrangeFox_X6886/releases) page for the latest builds.

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
