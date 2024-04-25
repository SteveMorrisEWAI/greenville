//import 'dart:convert';
//import 'package:flutter/services.dart';
import 'package:aiseek/data/dataproviders/device_management_provider.dart';
import 'package:aiseek/data/models/registered_devices.dart';
import 'package:aiseek/presentation/widgets/device_item.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navigation.dart';

class DevicesPage extends StatefulWidget {
  DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  var devicesMap;
  late Future<List<RegisteredDevice>> registeredDevicesFuture;
  bool isLoading = true;


  @override
  void initState() {
    Globals.setLastPage(AppConstants.devicesRouteName);
    registeredDevicesFuture = getRegisteredDevices().whenComplete(() => setState(() {
      isLoading = false;
    }));
    super.initState();
  }

  Future<List<RegisteredDevice>> getRegisteredDevices() async {
    DeviceManagementProvider registeredDevicesFuture = DeviceManagementProvider();
    List<RegisteredDevice> myMap = await registeredDevicesFuture.getData();
    Globals.printDebug(inText: 'PreviousSearchesPage PreviousSearchesProvider() myMap.length = ${myMap.length.toString()}');
    return myMap;
  }
  
  Future deleteDevice(deviceId) async {
    setState(() {
      isLoading = true;
    });

    bool request = await DeviceManagementProvider().deleteDevice(deviceId);
    
    if (request) {
      setState(() {
        registeredDevicesFuture = getRegisteredDevices().whenComplete(() => isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    const iconWidth = 29.0;
    const padding = 15.0;
    final defaultColorScheme = Theme.of(context).colorScheme;
    double deviceWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Devices', style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: defaultColorScheme.onBackground),
          onPressed: () {
            return context.pop();
          },
        ),
      ),
      bottomNavigationBar: BottomNavWidget(),
      body: Container(
        height: double.infinity, 
        color: defaultColorScheme.background,
        padding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        child: SingleChildScrollView(child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text('Head to desktop.aiseek.ai to link your computer to your account',
                              textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2,)),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  context.push(context.namedLocation(AppConstants.linkDeviceRouteName));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: defaultColorScheme.outline,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
                  child: Row(children: [
                      ConstrainedBox( 
                        constraints: BoxConstraints(maxWidth: deviceWidth - (padding*5) - iconWidth),
                        child: Text('Link New Device')
                      ),
                      Spacer(),
                      Image.asset('assets/images/rightarrow.png', width: iconWidth,),
                    ],
                  )
                  
                )
              ),
              SizedBox(height: 10,),
              FutureBuilder<List<RegisteredDevice>>(
                future: registeredDevicesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
                    return Center(child: CircularProgressIndicator(),) ;
                  }
                  if (snapshot.hasData) {
                    return buildDeviceList(snapshot.data!, deleteDevice);
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Text('');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDeviceList(List<RegisteredDevice> devices, Future deleteDevice(string)) {
    

    return Column(children: [
      ListView.separated(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: devices.length,
        itemBuilder: (context, index) {
          onPressDelete () {
            deleteDevice(devices[index].device_uuid);
          }
          return DeviceItem(tipText: devices[index].description, deviceId: devices[index].device_uuid, deleteDevice: onPressDelete);
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        )
      ),
    ],); 
  }
}
