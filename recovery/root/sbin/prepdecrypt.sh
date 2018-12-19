#!/sbin/sh

relink()
{
	fname=$(basename "$1")
	target="/sbin/$fname"
	sed 's|/system/bin/linker64|///////sbin/linker64|' "$1" > "$target"
	chmod 755 $target
}

finish()
{
	umount /v
	umount /s
	rmdir /v
	rmdir /s
	setprop crypto.ready 1
	exit 0
}

mkdir /v
mount -t ext4 -o ro /dev/block/bootdevice/by-name/vendor /v
mkdir /s
mount -t ext4 -o ro /dev/block/bootdevice/by-name/system /s

if [ -f /s/build.prop ]; then
	# TODO: It may be better to try to read these from the boot image than from /system
	osver=$(grep -i 'ro.build.version.release' /s/build.prop  | cut -f2 -d'=')
	patchlevel=$(grep -i 'ro.build.version.security_patch' /s/build.prop  | cut -f2 -d'=')
	resetprop ro.build.version.release "$osver"
	resetprop ro.build.version.security_patch "$patchlevel"
	finish
else
	# Be sure to increase the PLATFORM_VERSION in build/core/version_defaults.mk to override Google's anti-rollback features to something rather insane
	osver=$(getprop ro.build.version.release_orig)
	patchlevel=$(getprop ro.build.version.security_patch_orig)
	resetprop ro.build.version.release "$osver"
	resetprop ro.build.version.security_patch "$patchlevel"
	finish
fi

###### NOTE: The below is no longer used but I'm keeping it here in case it is needed again at some point!
mkdir -p /vendor/lib64/hw/

cp /s/lib64/android.hidl.base@1.0.so /sbin/
cp /s/lib64/libicuuc.so /sbin/
cp /s/lib64/libxml2.so /sbin/

relink /sbin/qseecomd

cp /v/lib64/libdiag.so /vendor/lib64/
cp /v/lib64/libdrmfs.so /vendor/lib64/
cp /v/lib64/libdrmtime.so /vendor/lib64/
cp /v/lib64/libGPreqcancel.so /vendor/lib64/
cp /v/lib64/libGPreqcancel_svc.so /vendor/lib64/
cp /v/lib64/libqdutils.so /vendor/lib64/
cp /v/lib64/libqisl.so /vendor/lib64/
cp /v/lib64/libqservice.so /vendor/lib64/
cp /v/lib64/libQSEEComAPI.so /vendor/lib64/
cp /v/lib64/librpmb.so /vendor/lib64/
cp /v/lib64/libsecureui.so /vendor/lib64/
cp /v/lib64/libSecureUILib.so /vendor/lib64/
cp /v/lib64/libsecureui_svcsock.so /vendor/lib64/
cp /v/lib64/libspcom.so /vendor/lib64/
cp /v/lib64/libspl.so /vendor/lib64/
cp /v/lib64/libssd.so /vendor/lib64/
cp /v/lib64/libStDrvInt.so /vendor/lib64/
cp /v/lib64/libtime_genoff.so /vendor/lib64/
cp /v/lib64/libkeymasterdeviceutils.so /vendor/lib64/
cp /v/lib64/libkeymasterprovision.so /vendor/lib64/
cp /v/lib64/libkeymasterutils.so /vendor/lib64/
cp /v/lib64/vendor.qti.hardware.tui_comm@1.0_vendor.so /vendor/lib64/
cp /v/lib64/hw/bootctrl.sdm845.so /vendor/lib64/hw/
cp /v/lib64/hw/android.hardware.boot@1.0-impl.so /vendor/lib64/hw/
cp /v/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so /vendor/lib64/hw/
cp /v/lib64/hw/android.hardware.keymaster@3.0-impl-qti.so /vendor/lib64/hw/

cp /v/manifest.xml /vendor/
cp /v/compatibility_matrix.xml /vendor/

relink /sbin/android.hardware.gatekeeper@1.0-service-qti
relink /sbin/android.hardware.keymaster@3.0-service-qti

finish
