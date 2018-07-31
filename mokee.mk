# 
# Copyright (C) 2018 The Mokee Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from clover device
$(call inherit-product, device/xiaomi/clover/device.mk)

# Inherit some common Mokee stuff.
$(call inherit-product, vendor/mk/config/common_full_tablet_wifionly.mk)

PRODUCT_NAME := mk_clover
PRODUCT_BRAND := Xiaomi
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_DEVICE := clover
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := MI PAD 4

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="clover" \
    PRODUCT_NAME="clover" \
    BUILD_FINGERPRINT="Xiaomi/clover/clover:8.1.0/OPM1.171019.019/8.7.26:user/release-keys" \
    PRIVATE_BUILD_DESC="clover-user 8.1.0 OPM1.171019.019 8.7.26 release-keys"

TARGET_VENDOR := Xiaomi
