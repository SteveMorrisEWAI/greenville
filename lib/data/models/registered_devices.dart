// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RegisteredDevice registeredDeviceFromJson(String str) => RegisteredDevice.fromJson(json.decode(str));

String RegisteredDeviceToJson(RegisteredDevice data) => json.encode(data.toJson());

class RegisteredDevice {
  RegisteredDevice({
    required this.device_uuid,
    required this.description,
  });

  String device_uuid;
  String description;

  factory RegisteredDevice.fromJson(Map<String, dynamic> json) => RegisteredDevice(
    device_uuid: json["device_uuid"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "device_uuid": device_uuid,
    "description": description,
  };
}

