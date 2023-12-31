#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

AB_OTA_UPDATER := true
BOARD_HAVE_QCOM_FM := true

# Inherit from sdm660-common
$(call inherit-product, device/xiaomi/sdm660-common/sdm660.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_intcodec.xml \
    $(LOCAL_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(LOCAL_PATH)/audio/sound_trigger_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths.xml \
    $(LOCAL_PATH)/audio/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl:64 \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service \
    bootctrl.sdm660 \
    bootctrl.sdm660.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Charger
PRODUCT_PACKAGES += \
    charger_led \
    charger_led_recovery

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck_ramdisk \
    tune2fs_ramdisk \
    resize2fs_ramdisk

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Init
PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom_first_stage_ramdisk \
    init.device.rc

# Health
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

# Recovery
PRODUCT_COPY_FILES += \
    vendor/xiaomi/sdm660-common/proprietary/vendor/bin/hvdcp_opti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/hvdcp_opti

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service-qti

# Inherit the proprietary files
$(call inherit-product, vendor/qualcomm/sdm455/sdm455-vendor.mk)

# Extra
EXTRA_DEVICE_BRACKET := low-end
#PRODUCT_EXCLUDE_IH8SN := true
