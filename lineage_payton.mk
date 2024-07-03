# Inherit some common Lineage stuff.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device
$(call inherit-product, device/motorola/payton/device.mk)

# Device identifiers
BUILD_FINGERPRINT := motorola/payton/payton:9/PPW29.69-40-4/4ca2a:user/release-keys
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := payton
PRODUCT_MANUFACTURER := Motorola
PRODUCT_MODEL := Moto X4
PRODUCT_NAME := lineage_payton

PRODUCT_BUILD_PROP_OVERRIDES += \
        PRODUCT_NAME=payton \
        PRIVATE_BUILD_DESC="payton-user 9 PPW29.69-40-4 4ca2a release-keys"
