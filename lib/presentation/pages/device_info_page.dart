import 'package:aiseek/data/dataproviders/device_info.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/presentation/widgets/map_listview.dart';

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  Map<String, dynamic> deviceData = {};
  DeviceInfo _deviceInfo = DeviceInfo();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    deviceData = await _deviceInfo.initPlatformState();

    if (!mounted) return;
    setState(() {
      deviceData;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      flexibleSpace: Container(decoration: BoxDecoration(color: Colors.white)),
      title: Text(AppConstants.deviceInfoPageTitle, style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold
      )),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          return context.pop();
        },
      ),
    ),
    body: MapListView(map: deviceData),
  );
}