import 'package:flutter/material.dart';

import '../../core/commons/globals.dart';

class DeviceItem extends StatefulWidget {
  final String tipText;
  final String deviceId;
  final VoidCallback deleteDevice;

  const DeviceItem({
    Key? key,
    this.tipText = '',
    this.deviceId = '', 
    required this.deleteDevice
  }) : super(key: key);

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem>  {
  
  @override
  Widget build(BuildContext context) {

    final defaultColorScheme = Theme.of(context).colorScheme;
    double deviceWidth = MediaQuery.of(context).size.width;
    const padding = 10.0;
    const iconWidth = 19.0;
    
    return 
    Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: defaultColorScheme.outline,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: defaultColorScheme.outline
      ),
      padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          // Spacer(flex: ,),
          // SizedBox(width: 10),
          ConstrainedBox( 
            constraints: BoxConstraints(maxWidth: deviceWidth - (padding*5) - iconWidth - 10),
            child: Text(widget.tipText)
          ),
          IconButton(onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Are you sure you want to un-link this device?'),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Globals.endGradient)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            SizedBox(width: 10,),
                            TextButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Globals.endGradient), foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                              onPressed: () {
                                widget.deleteDevice();
                                Navigator.pop(context);
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ), 
              icon: Icon(Icons.delete, color: defaultColorScheme.onBackground),)
        ],
      )
      
    );
  }
}
