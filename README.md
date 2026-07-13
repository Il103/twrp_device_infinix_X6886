# OrangeFox Recovery — Infinix X6886 (MT6789)

| | |
|---|---|
| **Device** | Infinix X6886 (Hot 30 VIP / smart 7 hd variants on MT6789) |
| **SoC** | MediaTek Helio G99 (MT6789) |
| **Arch** | arm64 (A/B + Virtual A/B) |
| **Recovery base** | OrangeFox **R14.1** (`fox_14.1`) |
| **Maintainer** | B E R U (@Il103) |

Device tree for building **OrangeFox R14.1** recovery (TWRP-based) for the Infinix X6886.

## What's inside ✨

- **OrangeFox R14.1 modern touch GUI** — no legacy Hardware GUI; gesture navigation + on-screen bottom navbar (toggleable via `OF_ALLOW_DISABLE_NAVBAR`).
- **Material YOU theming** — dynamic color, provided by the R14.1 base GUI (build against `fox_14.1` to get it).
- **120 Hz rendering** — `TW_FRAMERATE := 120` for smooth scrolling on the 120 Hz panel.
- **Flashlight** — torch toggled from the status bar; sysfs nodes pulled from the stock dump (`/sys/devices/virtual/torch/*`).
- **Vibrator / haptics** — node pulled from the stock dump (`/sys/class/leds/vibrator_single/*`), AIDL haptics enabled.
- **Force Format Data** — `OF_FORCE_DATA_FORMAT_F2FS` + `OF_WIPE_METADATA_AFTER_DATAFORMAT` so `/data` and `/metadata` are wiped cleanly (clears FBE / metadata-encryption keys).
- **No boot log screen** — `TW_NO_SHOW_LOG` hides the log page that used to appear (and hang) on entry.
- **Auto-decrypt** data with lockscreen credential (FBE v2 + Metadata Encryption).
- **MTP**, **Fastbootd**, **KernelSU**, **FRP** addon, **External SD**, **settings persistence** in `/cache`.
- **All languages** enabled (`TW_EXTRA_LANGUAGES`) with English default.

## Requirements

- Unlocked bootloader
- OrangeFox **R14.1** build tree — sync with `--branch 14.1` (e.g. `orangefox_sync.sh --branch 14.1`)
- AOSP / LineageOS 14.1-compatible sources

> The modern GUI, Material YOU, gesture navigation, swipe-from-top log panel and 120 Hz
> rendering are implemented in the **OrangeFox `fox_14.1` base**. Build against that base;
> this device tree only enables the features via the flags above.

## Build

```bash
source build/envsetup.sh
lunch ofox_X6886-ap2a-eng
export ALLOW_MISSING_DEPENDENCIES=true
m vendorbootimage
```

Output: `out/target/product/X6886/OrangeFox-R14.1-Unofficial-X6886.img`

Flash it via fastboot (`fastboot flash vendor_boot vendor_boot.img`) or your current recovery.

## Notes

- Uses the prebuilt stock kernel + DTB (`TARGET_NO_KERNEL := true`); builds as a `vendor_boot` image (header v4) with the recovery ramdisk.
- Flashlight/vibrator sysfs node permissions are set in `recovery/root/init.recovery.mt6789.rc` (values taken from the stock firmware dump).

## Downloads

See the [Releases](https://github.com/Il103/recovery_device_infinix_X6886/releases) page.

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
