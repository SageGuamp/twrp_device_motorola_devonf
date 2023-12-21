#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

add_lunch_combo twrp_devonf-user
add_lunch_combo twrp_devonf-userdebug
add_lunch_combo twrp_devonf-eng

# vendor_boot-as-recovery
	if [ "$OF_VENDOR_BOOT_RECOVERY" = "1" ]; then
	   export FOX_RESET_SETTINGS="disabled"
	   export FOX_VARIANT="vBaR"
	fi
