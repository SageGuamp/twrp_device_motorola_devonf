#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
#set -o xtrace
FDEVICE="devonf"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ "$THIS_DEVICE" = "alioth" -o "$THIS_DEVICE" = "munch" ]; then
	FDEVICE="$THIS_DEVICE"
	[ -z "$FOX_BUILD_DEVICE" ] && FOX_BUILD_DEVICE="$THIS_DEVICE"
fi

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" -a -z "$FDEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE1"  -o "$FOX_BUILD_DEVICE" = "$FDEVICE2" ]; then
	if [ -z "$THIS_DEVICE" ]; then
		echo "ERROR! This script requires bash. Run '/bin/bash' and build again."
		exit 1
	fi

    export FOX_VANILLA_BUILD=1
    export FOX_ENABLE_APP_MANAGER=1
	export FOX_VIRTUAL_AB_DEVICE=1
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_NANO_EDITOR=1
    export FOX_DELETE_AROMAFM=1

add_lunch_combo of_devonf-eng

# vendor_boot-as-recovery
	if [ "$OF_VENDOR_BOOT_RECOVERY" = "1" ]; then
	   export FOX_RESET_SETTINGS="disabled"
	   export FOX_VARIANT="vBaR"
	fi

#lz4; this can cause a bootloop in some ROMs, so don't use it except for lz4 ROMs
	if [ "$OF_USE_LZ4_COMPRESSION" = "1" ]; then
	   export FOX_VARIANT="lz4"
	fi
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
