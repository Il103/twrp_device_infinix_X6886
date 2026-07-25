# OrangeFox Recovery — Infinix X6886 (MT6789)

| | |
|---|---|
| **Device** | Infinix HOT 60 Pro Plus (X6886) |
| **SoC** | MediaTek MT6789 (Helio G200) |
| **Display** | 1224x2720 AMOLED, 144Hz, density 392 |
| **Touch** | FocalTech FT3683G |
| **Fingerprint** | Goodix (under-display) |
| **Storage** | UFS |
| **SIM** | Dual (DSDS) |
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
- **144 Hz** display refresh support
- **Material You** theme (selectable in Customization) + dark theme default
- **Gesture / modern navigation** (navbar can be disabled)
- **MTP**, **Fastbootd**, **External SD**, **Brightness** control
- **FRP** addon
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

## Format Data

If Format Data fails with "Failed to format block" or crypto errors:

1. Use `sbin/formatdata.sh` from adb shell, OR
2. Flash stock recovery first to format, then reflash OrangeFox

## Notes

- Flash via fastboot: `fastboot flash vendor_boot out/target/product/X6886/OrangeFox-R12.1-Unofficial-X6886.img`
- On first boot, enter your lockscreen password when prompted to decrypt `/data`.
- **fstab flags** match stock exactly (`checkpoint=fs`, `quota`, `fsverity`, `sysfs_path`) — critical for Format Data on MTK UFS.

## Specs (from stock dump)

- **CPU**: Cortex-A55 (4x) + Cortex-A76 (4x)
- **GPU**: Mali-G57 MC2
- **Camera**: 108MP main + 2MP depth
- **Battery**: 5000mAh, 33W fast charge
- **Android**: 15 (API 35), SELinux enforcing
- **TEE**: Trustonic

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
