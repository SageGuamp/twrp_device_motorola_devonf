#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/devonf

# vendor_boot as recovery
ifeq ($(OF_VENDOR_BOOT_RECOVERY),1)

$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    tune2fs.vendor_ramdisk
endif
# end: vendor_boot

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    bootctrl.mt6855

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# frame rate
TW_FRAMERATE := 120


# vendor_boot-as-recovery
ifeq ($(FOX_VENDOR_BOOT_RECOVERY),1)

$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# -------------------- 20230724: fs compression --------------------
  PRODUCT_FS_COMPRESSION := true
  OF_ENABLE_FS_COMPRESSION := 1
  # this can be used instead of "OF_ENABLE_FS_COMPRESSION"
  PRODUCT_VENDOR_PROPERTIES += vold.has_compress=true

  # compare build/make/target/product/virtual_ab_ota/android_t_baseline.mk (A13 manifest)
  PRODUCT_VIRTUAL_AB_COMPRESSION := true
  PRODUCT_VENDOR_PROPERTIES += ro.virtual_ab.compression.enabled=true
  PRODUCT_VENDOR_PROPERTIES += ro.virtual_ab.compression.xor.enabled=true
  PRODUCT_VENDOR_PROPERTIES += ro.virtual_ab.userspace.snapshots.enabled=true
  PRODUCT_VENDOR_PROPERTIES += ro.virtual_ab.io_uring.enabled=true
# -------------------- 20230724: fs compression --------------------

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/fstab-generic.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
#    $(DEVICE_PATH)/recovery/root/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk
endif
# end: vendor_boot-as-recovery

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
