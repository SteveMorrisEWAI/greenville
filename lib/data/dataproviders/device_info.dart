import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/app_constants.dart';

class DeviceInfo {
  Future<Map<String, dynamic>> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    Map<String, dynamic> deviceData = {};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = {"Error:": "Failed to get platform version."};
    }
    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    Globals.myDevice = build.device.toString();
    Globals.myModel = build.model.toString();
    Globals.myDeviceOS = build.version.codename.toString();
    Globals.AndroidMobileBrand = build.brand.toString();
    Globals.AndroidversionSdkInt = build.version.sdkInt.toString();
    Globals.Androidmanufacturer = build.manufacturer.toString();
    Globals.AndroidversionSecurityPatch = build.version.securityPatch.toString();
    Globals.AndroidversionRelease = build.version.release.toString();
    Globals.AndroidversionIncremental = build.version.incremental.toString();
    Globals.AndroidversionCodename = build.version.codename.toString();
    Globals.Androidboard = build.board.toString();
    Globals.Androidbootloader = build.bootloader.toString();
    Globals.Androiddisplay = build.display.toString();
    Globals.Androidfingerprint = build.fingerprint.toString();
    Globals.Androidhardware = build.hardware.toString();
    Globals.Androidhost = build.host.toString();
    Globals.Androidid = build.id.toString();
    Globals.Androidproduct = build.product.toString();
    Globals.AndroidsystemFeatures = build.systemFeatures.toString();
    Globals.AndroidID = build.id.toString();
    Globals.AndroidisPhysicalDevice = build.isPhysicalDevice.toString();

    return {
      'Install IP address': Globals.InstallIP,
      'Internal BrandID': AppConstants.Brand_id,
      'Device Guid': Globals.Guid,
      'My Device': Globals.myDevice,
      'My Model': Globals.myModel,
      'My DeviceOS': Globals.myDeviceOS,
      'Install Time Zone': Globals.InstallTimeZone.toString(),
      'Privacy Policy URL': Globals.PrivacyPolicyURL,
      'Message Display Limit': Globals.MessageDisplayLimit.toString(),
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt.toString(),
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt.toString(),
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis.toString(),
      'supported64BitAbis': build.supported64BitAbis.toString(),
      'supportedAbis': build.supportedAbis.toString(),
      'tags': build.tags.toString(),
      'type': build.type.toString(),
      'isPhysicalDevice': build.isPhysicalDevice.toString(),
      'androidId': build.id.toString(),
      'systemFeatures': build.systemFeatures.toString(),
      'RevenueCat Status': Globals.entitlementActive.toString(),
      'Debug flag': AppConstants.debug_flag.toString(),
      'Logger flag': AppConstants.logger_flag.toString(),
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    Globals.myDevice = data.name.toString();
    Globals.myModel = data.model.toString();
    Globals.myDeviceOS = data.systemName.toString() + data.systemVersion.toString();
    Globals.IOSlocalizedModel = data.localizedModel.toString();
    Globals.IOSidentifierForVendor = data.identifierForVendor.toString();
    Globals.IOSisPhysicalDevice = data.isPhysicalDevice.toString();
    Globals.IOSsystemVersion = data.systemVersion.toString();

    return {
      'Install IP address': Globals.InstallIP,
      'Device Guid': Globals.Guid,
      'My Device': Globals.myDevice,
      'My Model': Globals.myModel,
      'My DeviceOS': Globals.myDeviceOS,
      'Install Time Zone': Globals.InstallTimeZone.toString(),
      'Privacy Policy URL': Globals.PrivacyPolicyURL,
      'Message Display Limit': Globals.MessageDisplayLimit.toString(),
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': Globals.IOSisPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      'RevenueCat Status': Globals.entitlementActive.toString(),
      'Debug flag': AppConstants.debug_flag.toString(),
      'Logger flag': AppConstants.logger_flag.toString(),
    };
  }
}
