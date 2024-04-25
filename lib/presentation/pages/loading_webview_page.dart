import 'dart:async';
import 'package:aiseek/core/utilities/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/business_logic/cubits/next_page_state.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/data/dataproviders/gpt_result.dart';
import 'dart:convert';
//import 'package:aiseek/data/models/gpt_result_model.dart';
import 'package:aiseek/core/utilities/get_uri.dart';

class LoadingWebViewPage extends StatefulWidget {
  LoadingWebViewPage({Key? key}) : super(key: key);

  @override
  LoadingWebViewPageState createState() => LoadingWebViewPageState();
}

class LoadingWebViewPageState extends State<LoadingWebViewPage> {
  @override
  void initState() {
    Globals.setLastPage(AppConstants.loadingWebPageRouteName);
    Globals.newState = NextPageState(nextPageState: AppConstants.loadingWebPageRouteName);
    Globals.hasGPTLoadingFinished.addListener(() {
      Navigate2Results();
      Globals.printDebug(inText: 'Setup hasGPTLoadingFinished listener = ${Globals.hasGPTLoadingFinished.value.toString()}');
    });
    super.initState();
    Globals.printDebug(inText: 'LoadingWebViewPage initState B4 gptResult');
    Timer.periodic(Duration(milliseconds: 100), (_) => updateProgress());
    var myObject = GetResult();
    Globals.printDebug(inText: 'LoadingWebViewPage initState After gptResult myObject = ${myObject.toString()}');
  }

  double _timerProgress = 00.01;

  var counter = 0;
  void updateProgress() {
    if (_timerProgress < 00.99) {
      counter++;
    }
    setState(() {
      _timerProgress = 00.0075 * counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultColorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
        centerTitle: true,
        title: Text(AppConstants.loadingWebViewPageTitle, style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
      ),

      /// Spinner with multiple colors and custom shape
      body: Container(
          decoration: BoxDecoration(color: defaultColorScheme.background),
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            SpinKitThreeBounce(
              color: defaultColorScheme.onBackground,
              size: 40.0,
            )
          ]))),
    );
  }

  void Navigate2Results() {
    Globals.printDebug(inText: 'LoadingWebViewPage Before Navigate2Results()');
    if (Globals.hasGPTLoadingFinished.value) {
      Globals.hasGPTLoadingFinished.removeListener(() {});
      Globals.printDebug(inText: 'LoadingWebViewPage Loading finished Navigate2Results()');
//      hasGPTLoadingFinished.value = false;
      Globals.URLArray.initializeStack(inSource: 'LoadingWebViewPage');

      // context.pushNamed(AppConstants.resultsRouteName);
      return context.pushReplacementNamed(
        context.namedLocation(AppConstants.resultsRouteName),
      );
    } else {
      Globals.printDebug(inText: 'LoadingWebViewPage Navigate2Results() No navigation ${Globals.hasGPTLoadingFinished.value}');
    }
  }

  Future<dynamic> GetResult() async {
    GetUri _getUriObject = GetUri(AppConstants.GPTResultRef); // Setup the GetUri Object to get the gpt result
    Uri myUri = _getUriObject.SetUri();
    GPTResult _GPTResultObject = GPTResult(myUri); //Do the post to client_install
    Map gptResultModel = await _GPTResultObject.postData();
    String myJson = jsonEncode(gptResultModel);
    var object = json.decode(myJson);
    var prettyString = JsonEncoder.withIndent('  ').convert(object);
    prettyString = JsonEncoder.withIndent('  ').convert(gptResultModel);
    prettyString = prettyString; //Just added to remove warning
    Globals.printDebug(inText: 'LoadingWebViewPage GetResult() = ${prettyString}');

    Globals.printDebug(inText: 'Redirect to error = ${gptResultModel['status']}');
    if( gptResultModel['status'] == '402') {
      Globals.printDebug(inText: 'Redirect to error');

      context.push(context.namedLocation(AppConstants.usagePageRouteName,
                                queryParameters: {'errorMessage': 'You have used all of your monthly allowance. Please top up to continue using the app.'}));
    }
    if( gptResultModel['status'] == '422') {
      Globals.printDebug(inText: 'Redirect to error ${gptResultModel['errorMsg']}');
      context.push(context.namedLocation(AppConstants.promptPageRouteName,
                                queryParameters: {'errorMessage': gptResultModel['errorMsg']}));
    }

    Globals.currentHTMLPage = gptResultModel['my_html_page'];
    Globals.initialHTMLPage = gptResultModel['my_html_page'];
    Globals.currentShareHTMLPage = gptResultModel['share_html_page'];
    Globals.currentStaticHTMLPage = gptResultModel['static_html_page'];
    // String firstFive = Globals.currentHTMLPage.substring(0, 5);
    // Globals.printDebug(inText: 'FirstFive = $firstFive');
    // if (firstFive == 'ERROR') {
    //   Globals.printDebug(inText: 'Error found ${Globals.currentHTMLPage}');
    // }
    Globals.printDebug(inText: 'GPT-RESULT ENDING');

    Globals.hasGPTLoadingFinished.value = true;
    return gptResultModel;
  }
}
