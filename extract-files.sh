#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        # Load ZAF configs from vendor
        vendor/lib/libzaf_core.so)
            [ "$2" = "" ] && return 0
            sed -i -e 's|/system/etc/zaf|/vendor/etc/zaf|g' "${2}"
            ;;
        # Add uhid group for fingerprint service
        vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc)
            [ "$2" = "" ] && return 0
            sed -i -e 's|system input|system uhid input|g' "${2}"
            ;;
        # Fix camera recording
        vendor/lib/libmmcamera2_pproc_modules.so)
            [ "$2" = "" ] && return 0
            sed -i -e 's|ro.product.manufacturer|ro.product.nopefacturer|g' "${2}"
            ;;
        # Fix missing symbol _ZN7android8hardware7details17gBnConstructorMapE
        vendor/lib64/com.fingerprints.extension@1.0_vendor.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libhidlbase.so" "libhidlbase-v32.so" "${2}"
            ;;
        # Update libstdc++.vendor target name
        vendor/lib/libmmcamera_hdr_gb_lib.so | vendor/lib/libdualcameraddm.so | vendor/lib/libvideobokeh.so | vendor/lib64/libdualcameraddm.so | vendor/lib64/libvideobokeh.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=payton
export DEVICE_COMMON=msm8998-common
export VENDOR=motorola
export VENDOR_COMMON=${VENDOR}

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"
