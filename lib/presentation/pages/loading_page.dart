import 'package:aiseek/core/utilities/check_free_trial.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aiseek/core/utilities/app_startup.dart';
import 'package:aiseek/core/utilities/after_layout.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/business_logic/cubits/next_page_state.dart';
import 'package:go_router/go_router.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> with AfterLayoutMixin<LoadingPage> {
  @override
  void initState() {
    String mySource = 'LoadingPage';
    Globals.printDebug(inText: 'LoadingPage initState started');
    Globals.setLastPage(AppConstants.loadingRouteName);
    Globals.newState = NextPageState(nextPageState: AppConstants.loadingRouteName);
    Globals.printDebug(inText: 'LoadingPage B4 instantiation of AppStartup');
    AppStartup _appStartup = AppStartup(mySource);
    Globals.printDebug(inText: 'LoadingPage after instantiation of AppStartup B4 initSync');
    _appStartup.initAsync(mySource);
    Globals.printDebug(inText: 'LoadingPage after AppStartup initSync');
    super.initState();
    Globals.printDebug(inText: 'LoadingPage end of initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],

      /// Spinner with multiple colors and custom shape
      body: Container(
          ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Globals.printDebug(inText: 'LoadingPage afterFirstLayout Globals.revenueCatActive = ${Globals.entitlementActive.toString()}');
    String myPage = '';
    if (Globals.entitlementActive || CheckFreeTrial.isFreeTrialActive() && !Globals.isFreeTrialNull ) {
      Globals.printDebug(inText: 'LoadingPage afterFirstLayout going off to prompt page');
      myPage = AppConstants.promptPageRouteName;
    } else {
      Globals.printDebug(inText: 'LoadingPage afterFirstLayout going off to payments page');
      myPage = AppConstants.productPageRouteName;
      // myPage = AppConstants.promptPageRouteName;
    }
    Globals.printDebug(inText: 'LoadingPage afterFirstLayout myPage = $myPage');
    return context.go(context.namedLocation(myPage));
  }
}
