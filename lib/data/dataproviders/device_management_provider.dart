import 'dart:convert';

import 'package:aiseek/data/models/registered_devices.dart';
import 'package:http/http.dart' as https;

// import 'dart:developer';
import 'package:aiseek/core/commons/globals.dart';

import '../../core/commons/app_constants.dart';

class DeviceManagementProvider {
  DeviceManagementProvider();
  // final Uri myUri;
  var myReturn;

  Future<List<RegisteredDevice>> getData() async {
    final queryParameters = {
      'brand_id': AppConstants.Brand_id,
      'client_uuid': Globals.Guid,
    };
    var registeredDevicesUri = Uri.https(AppConstants.uriAuthority, AppConstants.registeredDevicesPath, queryParameters);
    https.Response response = await https.get(registeredDevicesUri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => RegisteredDevice.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
  

  Future registerDevice(deviceId, deviceName) async {

    final queryParameters = {
      'brand_id': AppConstants.Brand_id,
      'client_uuid': Globals.Guid,
      'device_uuid': deviceId,
      'description': deviceName,
    };
    Globals.printDebug(inText: 'Register Device API = ' + AppConstants.uriAuthority + AppConstants.registerDevicePath);
    var registerDeviceUri = Uri.https(AppConstants.uriAuthority, AppConstants.registerDevicePath, queryParameters);
    https.Response response = await https.post(registerDeviceUri);

    if (response.statusCode == 200) {
      Globals.printDebug(inText: 'Register Device API = ' + response.statusCode.toString());
      return true;
    } else {
      Globals.printDebug(inText: 'Register Device API = ' + response.statusCode.toString());
      return false;
    }
  }

  Future deleteDevice(deviceId) async {

    var deleteMap = {
      'client_uuid': Globals.Guid,
      'device_uuid': deviceId
    };

    var deleteUri = Uri.https(AppConstants.uriAuthority, AppConstants.deleteDevicePath, deleteMap);
    https.Response response = await https.delete(deleteUri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
