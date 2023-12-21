#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
#set -o xtrace
FDEVICE="devonf"

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
