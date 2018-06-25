#!/bin/bash
#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

LINEAGE_ROOT="$MY_DIR"/../../..

export DEVICE=payton
export DEVICE_COMMON=sdm660-common
export VENDOR=motorola

export DEVICE_BRINGUP_YEAR=2018

./../../$VENDOR/$DEVICE_COMMON/extract-files.sh $@

BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

# Load libSonyDefocus from vendor
CAMERA_IMX386="$BLOB_ROOT"/vendor/lib/libmmcamera_imx386.so
sed -i "s|/system/lib/hw/|/vendor/lib/hw/|g" "$CAMERA_IMX386"

# Load ZAF configs from vendor
ZAF_CORE="$BLOB_ROOT"/vendor/lib/libzaf_core.so
sed -i "s|/system/etc/zaf|/vendor/etc/zaf|g" "$ZAF_CORE"
