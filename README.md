# TWRP Device Tree for Infinix X6886 (MT6789)

| | |
|---|---|
| **Device** | Infinix X6886 |
| **SoC** | MediaTek Helio G99 (MT6789) |
| **Arch** | arm64 (A/B + VAB) |
| **Maintainer** | B E R U (@Il103) |

Device tree for building **OrangeFox R12.0** / **TWRP** recovery for the Infinix X6886.

## Features ✨

- **Vendor boot image** (header v4)
- **Auto-decrypt** with lockscreen password (FBE v2 + Metadata Encryption)
- **Auto-boot to system**
- **MTP** enabled
- **Fastbootd** support
- **Flashlight** toggle in status bar
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
- OrangeFox R12.0 build tree (based on Android 12)
- AOSP / LineageOS 12.1

## Build Notes

- Uses prebuilt kernel + DTB from stock (`TARGET_NO_KERNEL := true`)
- Builds as `vendor_boot` image (header version 4)
- Base device tree: `ofox-12.1` branch

## Build

```bash
source build/envsetup.sh
lunch ofox_X6886-eng
export ALLOW_MISSING_DEPENDENCIES=true
m vendorbootimage
```

Output: `out/target/product/X6886/OrangeFox-R12.0-Unofficial-X6886.img`

## Downloads

Check the [Releases](https://github.com/Il103/recovery_device_infinix_X6886/releases) page for the latest builds.

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
