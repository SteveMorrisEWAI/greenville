

import 'package:aiseek/data/dataproviders/device_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


import '../widgets/bottom_navigation.dart';

class LinkDevicePage extends StatefulWidget {
  LinkDevicePage({Key? key}) : super(key: key);

  @override
  State<LinkDevicePage> createState() => _LinkDevicePageState();
}

class _LinkDevicePageState extends State<LinkDevicePage> {
  bool detectedBarcode = false;

  @override
  void initState() {
    Globals.setLastPage(AppConstants.linkDeviceRouteName);
    super.initState();
  }

  MobileScannerController cameraController = MobileScannerController(autoStart: true);

  cameraFunc() {
    cameraController.dispose();
    cameraController = MobileScannerController(autoStart: true);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultColorScheme = Theme.of(context).colorScheme;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Link New Device', style: TextStyle(
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
        alignment: Alignment.center,
        color: defaultColorScheme.background,
        width: deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
              MobileScanner(
                fit: BoxFit.cover,
                controller: cameraController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  // final Uint8List? image = capture.image;
                  Globals.printDebug(inText: 'detectedBArcode:' + detectedBarcode.toString());
                  if( !detectedBarcode ) {
                    setState(() {
                      detectedBarcode = true;
                    });
                    for (final barcode in barcodes) {
                      registerDevice(barcode.rawValue);
                    }
                  } else {
                    Globals.printDebug(inText: 'detectedBArcode2:' + detectedBarcode.toString());
                  }
                },
                errorBuilder: (context, error, child) {
                  cameraController.stop();
                  cameraController.start();
                  return Container(child: Text('Camera loading...'),);
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('assets/images/focus.png', width: deviceWidth/2),
                SizedBox(height: 10,),
                Text('Place barcode in center of screen.', style: TextStyle(color: Color.fromRGBO(148, 49, 130, 1), fontSize: 16),),
              ],)

          
        ],
      ),
      ),
    );
  }

  Future registerDevice(barcodeInfo) async {
    var barcodeInfoArray = barcodeInfo.split('_');
    var deviceId = barcodeInfoArray[0];
    var deviceName = barcodeInfoArray[1];
    Globals.printDebug(inText: 'QR Code Found = ${deviceId} ${deviceName}');
    bool request = await DeviceManagementProvider().registerDevice(deviceId, deviceName);
    if (request) {
      Globals.printDebug(inText: request.toString());

      context.push(context.namedLocation(AppConstants.devicesRouteName));
    } else {
      Globals.printDebug(inText: 'Error registering device');
      var oldContext = context;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Error registering device. Check your subscription is active and that you are scanning the correct QR code.'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Globals.endGradient), foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                        oldContext.push(oldContext.namedLocation(AppConstants.devicesRouteName));

                      },
                      child: const Text('Ok'),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      );
              
    }
  }
}
