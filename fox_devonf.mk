#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from devonf device
$(call inherit-product, device/motorola/devonf/device.mk)

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root)

PRODUCT_DEVICE := devonf
PRODUCT_NAME := twrp_devonf
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g73 5G
PRODUCT_MANUFACTURER := motorola
PRODUCT_SHIPPING_API_LEVEL := 32
BOARD_SYSTEMSDK_VERSIONS := 32

# screen settings
OF_SCREEN_H := 2400
OF_STATUS_H := 100
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1

# other stuff
OF_IGNORE_LOGICAL_MOUNT_ERRORS := 1
OF_USE_GREEN_LED := 0

OF_QUICK_BACKUP_LIST := /boot;/data;

OF_ENABLE_LPTOOLS := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1

# ensure that /sdcard is bind-unmounted before f2fs data repair or format
OF_UNBIND_SDCARD_F2FS := 1

# no OTA menu
OF_DISABLE_OTA_MENU := 1


# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="devonf_g_vext-user 12 T1TNS33.14-90-9-2 bbccfa release-keys"

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery

BUILD_FINGERPRINT := motorola/devonf_g_vext/devonf:12/T1TNS33.14-90-9-2/bbccfa:user/release-keys
