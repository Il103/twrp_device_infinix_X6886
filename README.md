# OrangeFox Recovery — Infinix X6886 (MT6789)

| | |
|---|---|
| **Device** | Infinix HOT 60 Pro Plus (X6886) |
| **SoC** | MediaTek MT6789 (Helio G99) |
| **CPU** | 6x Cortex-A55 @2.0GHz + 2x Cortex-A76 @2.2GHz |
| **GPU** | Mali-G57 MC2 (Valhall) @1100MHz |
| **Display** | 1224x2720 AMOLED, 144Hz, density 392 |
| **Touch** | Goodix (under-display) |
| **Fingerprint** | Goodix (under-display) |
| **Storage** | UFS |
| **RAM** | LPDDR4X |
| **SIM** | Dual (DSDS) |
| **Arch** | arm64 — A/B + VAB |
| **Recovery** | OrangeFox R12.1 (Android 12.1) |
| **Maintainer** | B E R U (@Il103) |

## Partition Layout (Verified from Stock Dump)

| Partition | Block Device | Content | Notes |
|-----------|-------------|---------|-------|
| `/boot` | `/dev/block/by-name/boot` | **Kernel** (18.7MB vendor kernel) | A/B, slotselect |
| `/vendor_boot` | `/dev/block/by-name/vendor_boot` | Vendor ramdisk + DTB + kernel modules | Header v4, A/B |
| `/dtbo` | `/dev/block/by-name/dtbo` | Device Tree Overlay (8MB) | A/B |
| `/vbmeta` | `/dev/block/by-name/vbmeta` | AVB metadata | A/B, verification enabled |
| `/vbmeta_system` | `/dev/block/by-name/vbmeta_system` | System AVB keys | A/B |
| `/vbmeta_vendor` | `/dev/block/by-name/vbmeta_vendor` | Vendor AVB keys | A/B |

## Build

```bash
source build/envsetup.sh
lunch ofox_X6886-eng
export ALLOW_MISSING_DEPENDENCIES=true
m vendorbootimage
```

Output: `out/target/product/X6886/OrangeFox-R12.1-Unofficial-X6886.img`

Flash via fastboot:
```bash
fastboot flash vendor_boot out/target/product/X6886/OrangeFox-R12.1-Unofficial-X6886.img
```

## Features

- **Vendor boot image** (header v4) — builds as `vendorbootimage`
- **Auto-decrypt** with lockscreen password (FBE v2 + Metadata Encryption) on boot
- **Format Data** — wipes `/metadata` automatically (no encryption mismatch after format)
- **Flashlight** toggle (AW36515 LED driver, torch + sub_torch + flashlight_core)
- **Vibrator** feedback (regulator-based + AAC RichTap haptic)
- **144 Hz** display refresh support
- **Material You** theme + dark theme default
- **Gesture / modern navigation** (navbar can be disabled)
- **MTP**, **Fastbootd**, **External SD**, **Brightness** control
- **FRP** addon
- **Settings persistence** across reboots (stored in `/cache`)

## Format Data

If Format Data fails with "Failed to format block" or crypto errors:

1. Use `sbin/formatdata.sh` from adb shell, OR
2. Flash stock recovery first to format, then reflash OrangeFox

---

## WARNING: Custom Kernel / GKI Flashing

### This device uses a vendor kernel (NOT GKI)

The stock kernel is a **Transsion vendor kernel** built for MT6789. It is **NOT** a Generic Kernel Image (GKI). The device tree uses `TARGET_NO_KERNEL := true` with a prebuilt vendor kernel.

### DO NOT flash GKI kernels

Flashing a GKI kernel (e.g., from KernelSU GKI builds, or any `Image.gz`-based kernel) to the `/boot` partition **will brick your device** because:

1. **AVB (Android Verified Boot) is enabled** — the stock vbmeta verifies the kernel signature. A GKI kernel signed with a different key will fail verification and the bootloader will refuse to boot.
2. **Missing vendor drivers** — the vendor kernel contains Transsion/MTK-specific drivers for the touchscreen (Goodix), display (NT36672E AMOLED), fingerprint (Goodix), flashlight (AW36515), and other hardware. A GKI kernel lacks all of these.
3. **Both `/boot` and `/vendor_boot` may become unbootable** — if AVB fails at the `/boot` level, the entire boot chain is broken, and the device may not enter recovery.

### If you bricked your device

1. **Try entering Fastboot Mode**: Hold `Volume Down` + `Power` for 10 seconds
2. **Use Penumbra** (recommended — [GitHub](https://github.com/shomykohai/penumbra) | [Docs](https://penumbra.itssho.my/Penumbra/Antumbra/CLI)):

   **Download the DA file**: [DA_BR_MT6789_transsion.bin](https://www.mediafire.com/file/tgv1s2ffk69z6jq/DA_BR_MT6789_transsion.bin/file)

   **Install Penumbra (Linux)**:
   ```bash
   cargo install penumbra
   # Or download prebuilt from GitHub Releases: https://github.com/shomykohai/penumbra/releases
   # Linux: sudo adduser $USER dialout  # (then logout/login)
   ```

   **Unbrick commands**:
   ```bash
   # List all partitions:
   antumbra pgpt --da DA_BR_MT6789_transsion.bin

   # Disable AVB verification by flashing patched vbmeta:
   antumbra write vbmeta_a vbmeta_disabled.img --da DA_BR_MT6789_transsion.bin

   # Restore stock kernel:
   antumbra write boot_a stock_boot.img --da DA_BR_MT6789_transsion.bin
   antumbra write vendor_boot_a stock_vendor_boot.img --da DA_BR_MT6789_transsion.bin

   # Reboot to normal mode:
   antumbra reboot normal --da DA_BR_MT6789_transsion.bin
   ```
3. **If Penumbra does not work**: Use **SP Flash Tool** (MTK Flash Tool) with a scatter file as a last resort.

### What CAN be flashed to /boot

Only flash **stock boot.img** or a **vendor kernel built specifically for MT6789/X6886** to the `/boot` partition. Custom kernels must be built from the Transsion/MTK kernel source with all vendor drivers included.

---

## Notes

- On first boot, enter your lockscreen password when prompted to decrypt `/data`.
- **fstab flags** match stock exactly (`checkpoint=fs`, `quota`, `fsverity`, `sysfs_path`) — critical for Format Data on MTK UFS.
- Stock AVB uses Transsion-specific keys (`tran_avb.pubkey`) for `tr_*` partitions (tr_mi, tr_theme, tr_region, etc.).
- Stock uses DSDS (2 SIM).

## Hardware (Verified from Stock Dump)

- **CPU**: 6x Cortex-A55 (cluster0) + 2x Cortex-A76 (cluster1) — big.LITTLE
- **GPU**: Mali-G57 MC2 (Valhall architecture) @ 1100MHz
- **Display**: 1224x2720 AMOLED, 144Hz, panel NT36672E
- **Touch**: Goodix under-display
- **Fingerprint**: Goodix under-display
- **Flashlight**: AW36515 LED driver (kernel module)
- **Vibrator**: Regulator-based + AAC RichTap haptic
- **Storage**: UFS (ufshci@11270000)
- **TEE**: Trustonic
- **Charging**: MT6375
- **Android**: 15 (API 35), SELinux enforcing
- **WiFi/BT**: MediaTek connac (built-in)
- **AVB**: Enabled (Transsion vendor keys)

## Credits

- [Rey](https://github.com/rey-early) — base device tree
- OrangeFox Team
