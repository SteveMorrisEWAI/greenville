import 'package:aiseek/core/utilities/check_free_trial.dart';
import 'package:aiseek/core/utilities/themes.dart';
import 'package:aiseek/data/dataproviders/app_hints_provider.dart';
import 'package:aiseek/presentation/widgets/freeTrialBanner.dart';
import 'package:aiseek/presentation/widgets/suggestion_item.dart';
import 'package:aiseek/presentation/widgets/tip_item.dart';
import 'package:aiseek/presentation/widgets/usage_meter.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:clipboard/clipboard.dart';
import 'package:aiseek/core/commons/revenue_cat_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../data/models/app_hints_model.dart';
import '../widgets/bottom_navigation.dart';

Future<void> _getEntitlementStatus() async {
  Globals.printDebug(inText: 'PromptPage _getEntitlementStatus() B4 getting the latest customerInf');
  CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  Globals.entitlementActive = customerInfo.entitlements.active.isNotEmpty;
  Globals.printDebug(inText: 'PromptPage _getEntitlementStatus()Globals.entitlementActive = ${Globals.entitlementActive.toString()}');
}

void main() async {
  print('PromptPage Testing printDebug debug_flag = ${AppConstants.debug_flag.toString()}');
  WidgetsFlutterBinding.ensureInitialized();
  await _getEntitlementStatus();

  Globals.printDebug(inText: 'PromptPage After _getEntitlementStatus(); B4 runApp(PromptPage) ');

  runApp(PromptPage());
}



class PromptPage extends StatefulWidget {
  final String errorMessage;

  PromptPage({Key? key, this.errorMessage = ''}) : super(key: key);
  @override
  State<PromptPage> createState() => _PromptPageState();
}

@override
class _PromptPageState extends State<PromptPage> {
  TextEditingController controller = TextEditingController();
  String myPaste = '';
  ScrollController _scrollController = ScrollController();
  String outputFlag = AppConstants.defaultOutputFlag;
  bool isButtonActive = false;
  bool emptySearchAttempt = false;
  bool hasSearchBeenTapped = false;
  late Future<AppHint> appHintsFuture;
  AppHint appHints = AppHint(tips:[],suggestions:[]);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Globals.printDebug(inText: 'PromptPage initState ${Globals.entitlementActive.toString()}');
    Globals.setLastPage(AppConstants.promptPageRouteName);

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      Globals.addCustomerInfoUpdateListenerCount++;
      Globals.printDebug(
          inText:
              'PromptPage addCustomerInfoUpdateListener B4 getting the latest customerInfo. Counter = ${Globals.addCustomerInfoUpdateListenerCount.toString()}');
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
      revenueCatModel.revenueCatActive = customerInfo.entitlements.active.isNotEmpty;
      Globals.entitlementActive = customerInfo.entitlements.active.isNotEmpty;
      EntitlementInfo? entitlement = customerInfo.entitlements.all[AppConstants.entitlementID];
      Globals.entitlement = entitlement;
      Globals.printDebug(inText: 'PromptPage addCustomerInfoUpdateListener Globals.entitlementActive = ${Globals.entitlementActive.toString()}');
    });
    controller = TextEditingController();
    controller.addListener(() {
      isButtonActive = controller.text.isNotEmpty;
//      Globals.printDebug(inText: 'Home page TextController Listener = $isButtonActive');
      super.initState();
    });
    appHintsFuture = getAppHint();

  }

  Future<AppHint> getAppHint() async {
    AppHintsProvider appHintsProvider = AppHintsProvider();
    AppHint appHintsReturn = await appHintsProvider.getData();
    return appHintsReturn;
  }
  
  final DateFormat formatterDate = DateFormat('MMMM dd yyyy');
  final DateFormat formatterTime = DateFormat('Hm');
  
  
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    final defaultColorScheme = Theme.of(context).colorScheme;

    Globals.printDebug(inText: 'PromptPage started widget build');
    Globals.printDebug(inText: 'THEME ${Theme.of(context).brightness}');

    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: OrientationBuilder(
        builder: (context, orientation) {
          Globals.isPortrait = orientation == Orientation.portrait;
          Globals.isMobile = MediaQuery.of(context).size.shortestSide < 600;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottomOpacity: 0.0,
              elevation: 0.0,
              flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
              centerTitle: true,
              title: Theme.of(context).brightness == Brightness.dark ? Image.asset('assets/images/aiseeklogoondark.png', width: 70,) : Image.asset('assets/images/aiseeklogo.png', width: 70,),
            ),
            bottomNavigationBar: BottomNavWidget(),
            body: Container(
              height: double.infinity, 
              decoration: BoxDecoration(color: defaultColorScheme.background),
              child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: defaultColorScheme.background),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            if(widget.errorMessage != '') Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              width: deviceWidth,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: defaultColorScheme.errorContainer
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                color: defaultColorScheme.errorContainer,
                              ),
                              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                              child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.warning, color: defaultColorScheme.onErrorContainer,),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: new Text(widget.errorMessage, style: TextStyle(color: defaultColorScheme.onErrorContainer),)
                                )
                              ]),
                            ),
                            if(widget.errorMessage != '') SizedBox(height: 5),
                            // show free trial end date
                            FreeTrialBanner(),
                            UsageMeterWidget(alwaysShow: false,),
                            Scrollbar(
                              thumbVisibility: true,
                              controller: _scrollController,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: TextField(
                                  controller: controller,
                                  scrollController: _scrollController,
                                  maxLines: 5,
                                  minLines: 4,
                                  style: TextStyle(
                                    color: defaultColorScheme.onBackground,
                                    fontSize: 18,
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: defaultColorScheme.outline),
                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(7)),
                                        borderSide: BorderSide(color: defaultColorScheme.primary),
                                      ),
                                      hintText: 'Type your question here...'),
                                  onChanged: (s) => {
                                    Globals.currentPrompt = s.toString(),
                                    if (controller.text.isNotEmpty)
                                      {
                                        setState(() {
                                          isButtonActive = true;
                                        })
                                      }
                                    else
                                      {
                                        setState(() {
                                          isButtonActive = false;
                                        })
                                      },
                                    Globals.printDebug(inText: 'Something Changed'),
                                  },
                                ),
                              ),
                            ),
                            emptySearchAttempt ? Container(
                              child: Text('Type your question into the box above, then press the search button.'),
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            ) : SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: deviceWidth / 2.1,
                                  child: ElevatedButton(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text('Create'),
                                        SizedBox(width: 10),
                                        Icon(Icons.image)
                                      ]),
                                    style: Themes().primaryButtonStyle(context),//Globals.flatButtonStyle,
                                    onPressed: isButtonActive
                                        ? () {
                                          hasSearchBeenTapped = true;
                                          FocusScope.of(context).unfocus();
                                          Globals.printDebug(inText: 'PromptPage Search button tapped.');
                                          RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
                                          FocusScope.of(context).unfocus();
                                          Globals.currentPrompt = controller.text;
                                          Globals.hasGPTLoadingFinished.value = false;
                                          Globals.URLArray.initializeStack(inSource: 'PromptPage search button');
                                          Globals.generateImage = true;
                                          context.push(
                                            context.namedLocation(AppConstants.loadingWebPageRouteName),
                                          );

                                          if (revenueCatModel.revenueCatActive || CheckFreeTrial.isFreeTrialActive()) {
                                            Globals.printDebug(inText: 'Better Check Entitlement');
                                          }
                                          setState(() {
                                              emptySearchAttempt = false;
                                          });
                                        } : () {
                                          setState(() {
                                              emptySearchAttempt = true;
                                          });
                                        },
                                  ),
                                ),
                                SizedBox(),
                                SizedBox(
                                  width: (deviceWidth / 2) - 20,
                                  child: ElevatedButton(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text('Ask'),
                                      SizedBox(width: 10),
                                      Icon(Icons.format_align_left)
                                    ]),
                                    style: Themes().primaryButtonStyle(context),
                                    onPressed: isButtonActive
                                        ? () {
                                          hasSearchBeenTapped = true;
                                          FocusScope.of(context).unfocus();
                                          Globals.printDebug(inText: 'PromptPage Search button tapped.');
                                          RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
                                          FocusScope.of(context).unfocus();
                                          Globals.currentPrompt = controller.text;
                                          Globals.hasGPTLoadingFinished.value = false;
                                          Globals.URLArray.initializeStack(inSource: 'PromptPage search button');
                                          Globals.generateImage = false;
                                          context.push(
                                            context.namedLocation(AppConstants.loadingWebPageRouteName),
                                          );

                                          if (revenueCatModel.revenueCatActive || CheckFreeTrial.isFreeTrialActive()) {
                                            Globals.printDebug(inText: 'Better Check Entitlement');
                                          }
                                          setState(() {
                                              emptySearchAttempt = false;
                                          });
                                        } : () {
                                          setState(() {
                                              emptySearchAttempt = true;
                                          });
                                        },
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 30),
                            FutureBuilder<AppHint>(
                              future: appHintsFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  return buildAppHints(snapshot.data!);
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
                  ],
                ),
              ),
            ),
            )
          );
        },
      ),
    );
  }

  Widget buildAppHints(AppHint appHints) {
    return Column(children: [
      ListView.separated(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: appHints.tips.length,
        itemBuilder: (context, index) {
          return TipItem(tipText: appHints.tips[index]);
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        )
      ),
      SizedBox(height: 30),
      Text('Try a suggestion', style: AppConstants.GeneralHeadingStyle, ),
      ListView.separated(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: appHints.suggestions.length,
        itemBuilder: (context, index) {
          return SuggestionItem(tipText: appHints.suggestions[index]);
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        )
      ),
    ],); 
  }

  void pasteFunc() async {
    final value = await FlutterClipboard.paste();

    setState(
      () {
        this.myPaste = value;
        controller.text = this.myPaste;
        Globals.printDebug(inText: 'Paste Func = $myPaste');
      },
    );
  }

  void copyFunc() async {
    await FlutterClipboard.copy(controller.text);
    Globals.printDebug(inText: 'Current prompt = ${controller.text}');
  }
}