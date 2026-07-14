#
# Copyright (C) 2024 OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

add_lunch_combo ofox_X6886-ap2a-eng
add_lunch_combo ofox_X6886-ap2a-userdebug
add_lunch_combo ofox_X6886-ap2a-user

# OrangeFox R14.1 maintainer patch version
export FOX_MAINTAINER_PATCH_VERSION=1
export FOX_BUILD_TYPE="Stable"

# Build a recovery for a vendor_boot-as-recovery (hdr4) device
export FOX_VENDOR_BOOT_RECOVERY=1

# Fix: keystore2 crashes (SIGABRT) in recovery, causing a hang at the splash
# while trying to decrypt /data (FBE metadata encryption). Replace keystore2
# with the prebuilt api_36 version which works standalone in recovery.
export FOX_ADD_API_V36_PREBUILTS=2
