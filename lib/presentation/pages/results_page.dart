import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../widgets/bottom_navigation.dart';


class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

enum MyMenuItems { Settings, Share, ViewSearch, NewSearch, Exit }

class _ResultsPageState extends State<ResultsPage> with WidgetsBindingObserver {
  late WebViewController wv_controller;
  var loadingPercentage = 0;
  var currentUrl = "";

  @override
  void initState() {
    Globals.setLastPage(AppConstants.resultsRouteName);
    Globals.URLArray.initializeStack(inSource: 'ResultsPage initState');
    Globals.hasGPTLoadingFinished.value = false;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Globals.printDebug(inText: 'WEBVIEW INIT');

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Globals.printDebug(inText: 'ResultsPage didChangeAppLifecycleState state = $state');
    super.didChangeAppLifecycleState(state);
    Globals.printDebug(inText: 'ResultsPage didChangeAppLifecycleState Returned to');
    if (state == AppLifecycleState.resumed) {
      Globals.URLArray.initializeStack(inSource: 'ResultsPage didChangeAppLifecycleState');
      Globals.printDebug(inText: 'ResultsPage didChangeAppLifecycleState state = $state');
    }
  }

  late WebViewController controller;


  @override
  Widget build(BuildContext context) {
    Globals.printDebug(inText: 'WEBVIEW LOADING ${widget.key}');
    final defaultColorScheme = Theme.of(context).colorScheme;

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
    ..addJavaScriptChannel('Download', onMessageReceived: (message) async => saveImage(message.message))
    ..setBackgroundColor(defaultColorScheme.background)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          Globals.printDebug(inText: 'onPageStarted WebView onPageStarted url = $url');
          Globals.printDebug(inText: 'onPageStarted WebView secondURL = ${Globals.URLArray.secondURL()}');
          Globals.currentLoadedPage = url;
          if (url == Globals.currentStaticHTMLPage) {
            Globals.printDebug(inText: 'OnPageStarted is static Page reset stack');
            Globals.URLArray.initializeStack(inSource: 'ResultsPage onPageStarted static');
          }
          bool myPushReturn = false;
          if (url != Globals.URLArray.firstURL()) {
            myPushReturn = Globals.URLArray.push(url);
          }
          Globals.printDebug(inText: 'OnPageStarted myPushReturn = ${myPushReturn.toString()} ');
          Globals.printDebug(inText: 'OnPageStarted initialPage after push stackCount  = ${Globals.URLArray.stackSize().toString()}');
          Globals.printDebug(inText: 'onPageStarted WebView secondURL = ${Globals.URLArray.secondURL()}');
          Globals.printDebug(inText: 'onPageStarted WebView firstURL = ${Globals.URLArray.firstURL()}');
          if (url == Globals.initialHTMLPage) {
            Globals.printDebug(inText: 'OnPageStarted initial so replace currentHTML with static HTML');
            Globals.currentHTMLPage = Globals.currentStaticHTMLPage;
          }
          int stackCount = Globals.URLArray.stackSize();
          Globals.printDebug(inText: 'onPageStarted After URLPush stackCount = ${stackCount.toString()} and url = $url');
        },
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse(Globals.currentHTMLPage));

    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        bottomNavigationBar: BottomNavWidget(selectExisting: false,),
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: defaultColorScheme.onBackground),
            tooltip: 'Back',
            onPressed: _onBack,
          ),
          actionsIconTheme: IconThemeData(color: defaultColorScheme.onBackground),
          title: Theme.of(context).brightness == Brightness.dark ? Image.asset('assets/images/aiseeklogoondark.png', width: 70,) : Image.asset('assets/images/aiseeklogo.png', width: 70,),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: defaultColorScheme.onBackground),
              tooltip: 'Share',
              onPressed: () {
                Globals.printDebug(inText: "Share");
                if (Platform.isIOS) {
                  Share.share(Globals.currentShareHTMLPage, subject: 'AI Seek page', sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100)); //Jira AISEEK-67
                } else {
                  Share.share(Globals.currentShareHTMLPage, subject: 'AI Seek page');
                }
              }
            ),
          ],
        ),
        body: WebViewWidget(controller: controller),
          
      ),
    );
  }

  void saveImage(String message) async {
      final imagePath = '${Directory.systemTemp.path}/image.jpg';
      await Dio().download('$message',imagePath).then((value) async => await Gal.putImage(imagePath).then((value) => Fluttertoast.showToast(
        msg: "Image saved to your photos",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Globals.stdBackgroundColor,
        textColor: Colors.white,
        fontSize: 16.0
      )));
      

      
  }

  void copyFunc() async {
    await FlutterClipboard.copy(Globals.currentHTMLPage);
    Globals.printDebug(inText: 'Current HTML Page  = ${Globals.currentHTMLPage}');
  }

  Future<bool> _onBack() async {
    Globals.printDebug(inText: '_onBack stack = ${Globals.URLArray.stackSize()}, First URL = ${Globals.URLArray.firstURL()} ');
    Globals.printDebug(inText: '_onBack  Second URL = ${Globals.URLArray.secondURL()} ');
    var value = await controller.canGoBack(); // check webview can go back
    Globals.printDebug(inText: '1 _onBack Started value = ${value.toString()}');
    if (Globals.URLArray.stackSize() < 2) // Stack size is one or zero so pop page
    {
      Globals.printDebug(inText: '1.5 _onBack stackSize =  ${Globals.URLArray.stackSize().toString()} so always pop to previous page ');
      return navigationFunction(navType: 'pop');
    }
    Globals.printDebug(inText: '2 _onBack currentHTML = ${Globals.currentLoadedPage} and stackSize = ${Globals.URLArray.stackSize().toString()}');
    if (Globals.currentLoadedPage == Globals.initialHTMLPage) //Checking for initialURL
    {
      Globals.printDebug(inText: '3 _onBack Initial page found from back button. Return to search page');
      return navigationFunction(navType: 'loadStaticPage');
    } else if (Globals.currentLoadedPage == Globals.currentStaticHTMLPage) //Static page alys app pop a page
    {
      Globals.printDebug(inText: '3.5 static page, app navigation pop');
      return navigationFunction(navType: 'pop');
    } else if (Globals.URLArray.secondURL() == Globals.initialHTMLPage) //Initial page is next so load static page
    {
      Globals.printDebug(inText: '3.75 Second URL is initial Page so load static page');
      return navigationFunction(navType: 'loadStaticPage');
    } else if (Globals.URLArray.stackSize() == 2) {
      Globals.printDebug(inText: '4.5 _onBack stackSize = 2');
      if (Globals.URLArray.secondURL() == Globals.initialHTMLPage) {
        Globals.printDebug(inText: '5 _onBoard second URL is Initial URL');
        Globals.currentHTMLPage = Globals.currentStaticHTMLPage;
        Globals.URLArray.initializeStack(inSource: 'ResultsPage 2nd  item initial page');
        controller.loadRequest(Uri().resolve(Globals.currentStaticHTMLPage));
        return false;
      } else // There are two items in the stack but the second one is not the initial page so just goBack one in the stack
      {
        Globals.printDebug(inText: '6 _onBack going back a page in WebView from ${Globals.URLArray.firstURL()}');
        return navigationFunction(navType: 'goBack'); //Just a regular navigated page}
      }
    }
    Globals.printDebug(inText: '7 _onBack going back a page in WebView from ${Globals.URLArray.firstURL()}');
    return navigationFunction(navType: 'goBack'); //Just a regular navigated page
  }

  bool navigationFunction({required String navType}) {
    Globals.printDebug(inText: 'navigationFunction navType = $navType');
    for (int i = 0; i < Globals.URLArray.stackSize(); i++) {
      String myStr = Globals.URLArray.findItem(inItem: i);
      Globals.printDebug(inText: 'navigationFunction i = $i, url = $myStr');
    }
    if (navType == 'pop') {
      Globals.URLArray.initializeStack(inSource: 'navigationFunction pop');
      context.pop(); //Navigate to previous page
      return false;
    } else if (navType == AppConstants.promptPageRouteName) {
      Globals.URLArray.initializeStack(inSource: 'navigationFunction homeRouteName');
      context.pushReplacementNamed(AppConstants.promptPageRouteName);
      return false;
    } else if (navType == AppConstants.previousSearchesRouteName) {
      Globals.URLArray.initializeStack(inSource: 'navigationFunction PreviousSearchesRouteName');
      context.pushNamed(AppConstants.previousSearchesRouteName);
      return false;
    } else if (navType == AppConstants.settingsRouteName) {
      Globals.URLArray.initializeStack(inSource: 'navigationFunction settingsRouteName');
      context.pushNamed(AppConstants.settingsRouteName);
      return false;
    } else if (navType == 'loadStaticPage') {
      Globals.URLArray.initializeStack(inSource: 'navigationFunction loadStaticPage');
      Globals.currentHTMLPage = Globals.currentStaticHTMLPage;
      Globals.printDebug(inText: 'navigationFunction B4 Loading static Page');
      controller.loadRequest(Uri().resolve(Globals.currentStaticHTMLPage));
      return false;
    } else if (navType == 'goBack') {
      Globals.printDebug(inText: 'navigationFunction B4 goBack');
      Globals.URLArray.pop();
      controller.goBack();
      return false;
    }
    Globals.printDebug(inText: 'navigationFunction UNKNOWN navType = $navType');
    return true;
  }
}

//settingsRouteName
