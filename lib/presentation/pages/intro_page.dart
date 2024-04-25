import 'dart:async';
import 'dart:io';

import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/utilities/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/global_func.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';
import 'package:aiseek/core/commons/revenue_cat_model.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  bool isButtonActive = false;
  bool hasSearchBeenTapped = false;
  int freeTrialLength = Globals.FreeTrialLength;

  GlobalFunc _globalFunc = GlobalFunc();

  Timer? timer; 

  @override
  void initState() {
    Globals.paymentPageCount++;
    Globals.printDebug(inText: 'PaymentPage initState ${Globals.entitlementActive.toString()} Payment Count  ${Globals.paymentPageCount.toString()}');

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      Globals.addCustomerInfoUpdateListenerCount++;
      Globals.printDebug(
          inText:
              'PaymentPage addCustomerInfoUpdateListener B4 getting the latest customerInfo. Counter = ${Globals.addCustomerInfoUpdateListenerCount.toString()}');
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
      revenueCatModel.revenueCatActive = customerInfo.entitlements.active.isNotEmpty;
      Globals.entitlementActive = customerInfo.entitlements.active.isNotEmpty;
      EntitlementInfo? entitlement = customerInfo.entitlements.all[AppConstants.entitlementID];
      Globals.entitlement = entitlement;
      _globalFunc.printWrapped('PaymentPage addCustomerInfoUpdateListener Entitlement = ${entitlement.toString()}');
      Globals.customerInfo = customerInfo;
      _globalFunc.printWrapped('PaymentPage addCustomerInfoUpdateListener customerInfo = ${customerInfo.toString()}');
      Globals.printDebug(
          inText:
              'PaymentPage addCustomerInfoUpdateListener Globals.revenueCatActive = ${Globals.entitlementActive.toString()} new value is  ${revenueCatModel.revenueCatActive.toString()}');
      if (Globals.entitlementActive) {
        Globals.printDebug(inText: 'PaymentPage addCustomerInfoUpdateListener payment receipt detected ');
        Globals.printDebug(inText: 'PaymentPage listener off to prompt page');
        return context.go(context.namedLocation(AppConstants.promptPageRouteName));
      }
      Globals.entitlementActive = revenueCatModel.revenueCatActive;
      Globals.printDebug(
          inText: 'PaymentPage addCustomerInfoUpdateListener set storage revenueCatModel.revenueCatActive = ${revenueCatModel.revenueCatActive.toString()}');
    });

    Globals.setLastPage(AppConstants.introPageRouteName);

    checkFreeTrialLength();

    super.initState();
  }

  void checkEntitlement() async {
    Globals.printDebug(inText: 'PaymentPage checkEntitlement Started');

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
    revenueCatModel.revenueCatActive = customerInfo.entitlements.active.isNotEmpty;
    Globals.entitlementActive = revenueCatModel.revenueCatActive;
    Globals.entitlementActive = revenueCatModel.revenueCatActive = customerInfo.entitlements.active.isNotEmpty;
    Globals.printDebug(
        inText:
            'PaymentPage revenueCatModel.revenueCatActive = ${revenueCatModel.revenueCatActive.toString()} & revenueCatActive = ${Globals.entitlementActive.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    Globals.printDebug(inText: 'PaymentPage Building widget');

    double padding = 10;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(width: double.infinity - 100, height: 70.0, child: Theme.of(context).brightness == Brightness.dark ? Image.asset('assets/images/aiseeklogoondark.png') : Image.asset('assets/images/aiseeklogo.png')),
                SizedBox(height: 30),
                Text('AI Seek requires a subscription - but you can test it out with our free, fully functional trial!',
                            textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize + 1.5, fontWeight: FontWeight.w700)),
                SizedBox(height: 5),
                Text('You will not be charged at any point when using the trial.',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                if (freeTrialLength > -1 ) Text('To continue using AI Seek once the '+ freeTrialLength.toString() +'-day trial is over you can choose to sign up for a monthly or annual auto-renewing subscription',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500)),
                
                Column(
                  children: (freeTrialLength > -1) ? [

                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.symmetric(vertical: BorderSide.none, horizontal: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(freeTrialLength.toString() + '-Day Trial',
                                    textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                                  Text('Fully functional, no subscription needed.',
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500, overflow: TextOverflow.visible )),
                                

                                ]
                              ),
                            
                            Text('Free',
                                    textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                          ],
                          )
                        )
                      ),

                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity - 100,
                        height: 50.0,
                        child: ElevatedButton(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Continue with ' + freeTrialLength.toString() + '-day no obligation free trial', textAlign: TextAlign.center),
                            ),
                            style: Themes().subscribeButtonStyle(context),
                            onPressed: () async {
                              return context.go(context.namedLocation(AppConstants.promptPageRouteName));
                            }),
                      ),
                      SizedBox(height: 15),

                      Text('Once the trial is over, you can sign up for our subscription:',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500)),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Globals.monthlyProduct.title ,
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                                  Text('Automatically renews every month',
                                    textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500)),
                                ]
                              ),
                              Text(Globals.monthlyProduct.priceString ,
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                            ],
                          )
                        ),
                      ),

                      if (AppConstants.debug_flag)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.symmetric(vertical: BorderSide.none, horizontal: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(Globals.annualProduct.title ,
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                                    Text('Automatically renews every year',
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Text(Globals.annualProduct.priceString ,
                                        textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize * 1.2, fontWeight: FontWeight.w700)),
                            ])
                          ),
                        ),

                      
                  ] : [
                    SizedBox(height: 30),
                    CircularProgressIndicator(),
                  ]
                ),
                

                
                SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: 
                        !Platform.isIOS ? [
                          Center(
                            child: TextButton(
                              child: Text('Restore purchase'),
                              onPressed: restorePurchases,
                            )
                          ),
                          Center(
                            child: TextButton(
                              child: Text('Manage Subscription'),
                              onPressed: () {
                                context.push(context.namedLocation(AppConstants.genericWebviewRouteName,
                                    queryParameters: {'url': AppConstants.managesubAndroidURL, 'title': 'Manage Subscription', 'showBack': 'true'}));
                              },
                            )
                          )
                        ] : [
                          Center(
                            child: TextButton(
                              child: Text('Restore purchase'),
                              onPressed: restorePurchases,
                            )
                          ),
                        ],
                    ),
                        
                    ]),
                ),
                    
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        TextButton(
                          child: Text('Terms of use'),
                          onPressed: () {
                            context.push(context.namedLocation(AppConstants.genericWebviewRouteName,
                                queryParameters: {'url': AppConstants.termsOfUseURL, 'title': 'Terms of use', 'showBack': 'true'}));
                          },
                        ),
                        TextButton(
                          child: Text('Privacy policy'),
                          onPressed: () {
                            context.push(context.namedLocation(AppConstants.genericWebviewRouteName,
                                queryParameters: {'url': AppConstants.privacyPolicyURL, 'title': 'Privacy Policy', 'showBack': 'true'}));
                          },
                        )
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      Globals.customerInfo = customerInfo;
      // ... check restored purchaserInfo to see if entitlement is now active
      checkEntitlement();
      setState(() {
        Globals.paymentPageInitialText = AppConstants.paymentPageWaitText;
      });
    } on PlatformException catch (e) {
      // Error restoring purchases
      Globals.printDebug(inText: 'PaymentPage Restore Purchases Error = ${e.toString()}');
      setState(() {
        Globals.paymentPageInitialText = AppConstants.paymentPageInitialText;
      });
    }
  }

  void checkFreeTrialLength() async {
      if (mounted) {
        if( Globals.FreeTrialLength == -1 ) {
          timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkFreeTrialLength());
          Globals.printDebug(inText: 'introPage start trial check is zero = ${Globals.FreeTrialLength}');
        } else {
          Globals.printDebug(inText: 'introPage start trial check is not zero = ${Globals.FreeTrialLength}');

          setState(() {
            freeTrialLength = Globals.FreeTrialLength;
          });
          if( Globals.FreeTrialLength == 0 ) {
            return context.go(context.namedLocation(AppConstants.paymentPageRouteName));
          }

          timer?.cancel();
        }
      }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   return context.go(
  //     context.namedLocation(AppConstants.promptPageRouteName),
  //   );
  // }
  void popUpSingleButton(BuildContext context, {String? title, String? buttonText, String? content}) {
    Globals.printDebug(inText: 'PaymentPage popUpSingleButton');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(content ?? ""),
          actions: <Widget>[
            ElevatedButton(
              child: Text(buttonText ?? "Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
// Visibility(
//   visible: _showMessage,
//   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('1 Month', style: TextStyle(fontSize: 16)),
//                         Text(
//                           "\$14.99",
//                           textAlign: TextAlign.end,
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
//                         )
//                       ],
//                     ),
// ),
