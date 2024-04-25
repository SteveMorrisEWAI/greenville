import 'package:aiseek/core/utilities/themes.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

import '../widgets/bottom_navigation.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late WebViewController settings_wv_controller;
  String versionNumber = '';
  String buildNumber = '';

  @override
  void initState() {
    Globals.setLastPage(AppConstants.settingsRouteName);

    _getPackageInfo();

    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    final defaultColorScheme = Theme.of(context).colorScheme;
    const iconWidth = 29.0;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Settings', style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(),
      body: Container(
        color: defaultColorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                context.push(context.namedLocation(AppConstants.usagePageRouteName));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(
                        'Your Usage',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColorScheme.onBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/rightarrow.png', width: iconWidth,),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Themes().settingsDivider(context),
            GestureDetector(
              onTap: () async {
                context.push(context.namedLocation(AppConstants.devicesRouteName));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(
                        'Linked Devices',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColorScheme.onBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/rightarrow.png', width: iconWidth,),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Themes().settingsDivider(context),
            GestureDetector(
              onTap: () async {
                // settings_wv_controller.loadUrl(AppConstants.privacyPolicyURL);
                context.push(context
                    .namedLocation(AppConstants.genericWebviewRouteName, queryParameters: {'url': AppConstants.privacyPolicyURL, 'title': 'Privacy Policy', 'showBack': 'true'}));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColorScheme.onBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/rightarrow.png', width: iconWidth,),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Themes().settingsDivider(context),
            GestureDetector(
              onTap: () async {
                // settings_wv_controller.loadUrl(AppConstants.disclaimerURL);
                context.push(
                    context.namedLocation(AppConstants.genericWebviewRouteName, queryParameters: {'url': AppConstants.disclaimerURL, 'title': 'Disclaimer', 'showBack': 'true'}));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(
                        'Disclaimer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColorScheme.onBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/rightarrow.png', width: iconWidth),
                    SizedBox(width: 10,)
                  ],
                ),
              )
            ),
            Themes().settingsDivider(context),
            GestureDetector(
              onTap: () async {
                context.push(context.namedLocation(AppConstants.genericWebviewRouteName,
                                queryParameters: {'url': (Platform.isIOS)?AppConstants.termsOfUseURL: 'https://www.aiseek.ai/app-terms-of-use/', 'title': 'Terms of use', 'showBack': 'true'}));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(
                        'Terms of Use',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: defaultColorScheme.onBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/rightarrow.png', width: iconWidth,),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Themes().settingsDivider(context),
            Expanded(
              child: Container(
                width: double.infinity - 100,
                padding: EdgeInsets.fromLTRB(0.0, 30, 0, 0),
                child: GestureDetector(
                    child: Text(
                      'Copyright 2023 Bubblr \nAll Rights Reserved\nv. ' + versionNumber + ' (' + buildNumber + ')',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      if (!AppConstants.logger_flag) return;
                      shareFunc();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getPackageInfo() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
    Globals.printDebug(inText: versionNumber);
  }

  // _loadHtmlFromAssets() async {
  //   String fileText = await rootBundle.loadString('assets/copyright.html');
  //   settings_wv_controller.loadUrl(Uri.dataFromString(fileText, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  // }
  void shareFunc() {
    if (!AppConstants.logger_flag) {
      return;
    }
    final StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write('AI Seek Log at ${DateTime.now().toString()}\n');
    stringBuffer.write('Total debug items =  ${Globals.logData.length.toString()}\n');

    for (final String item in Globals.logData) {
      stringBuffer.write('$item\n');
    }
    stringBuffer.write('End of Log');
    if (Platform.isIOS) {
      Share.share(stringBuffer.toString(), subject: 'AI Seek Logs', sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100)); //Jira AISEEK-67
    } else {
      Share.share(stringBuffer.toString(), subject: 'AI Seek Logs'); //Jira AISEEK-67
    }
  }
}
