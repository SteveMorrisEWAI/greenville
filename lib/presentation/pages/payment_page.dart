//AISEEK-114 Change to buttons
//AISEEK-144 Change payment method 30/7/2023
import 'dart:io';

import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';
import 'package:aiseek/core/utilities/themes.dart';
import 'package:aiseek/presentation/widgets/bottom_navigation.dart';
import 'package:aiseek/presentation/widgets/freeTrialBanner.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/global_func.dart';
import 'package:intl/intl.dart';
//import 'package:package_info_plus/package_info_plus.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
//import 'package:aiseek/presentation/widgets/paywall.dart';
import 'package:flutter/services.dart';
//import 'package:aiseek/presentation/widgets/native_dialog.dart';
import 'package:aiseek/core/commons/revenue_cat_model.dart';
import 'package:provider/provider.dart';
import 'package:aiseek/presentation/widgets/subscription_button.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isButtonActive = false;
  bool hasSearchBeenTapped = false;
  StoreProduct _selectedPackage = Globals.monthlyProduct;

  GlobalFunc _globalFunc = GlobalFunc();

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

    Globals.setLastPage(AppConstants.paymentPageRouteName);
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

  DateTime freeTrialEnd = Globals.FreeTrialEndDate;

  Future<DateTime> getTrialDate() async {
    var freeTrial = Globals.FreeTrialEndDate;
    await SharedPreferenceStorage.getFreeTrialExpiry().then((freeTrialExpiryString) => {
      freeTrial = DateTime.parse(freeTrialExpiryString)
    });
    return freeTrial;
  }

  refreshTrialDate() async {
    await Future.delayed(const Duration(seconds: 2));
    getTrialDate().then((value) => {
      ( value.year != 2000) ? setState(() {
        freeTrialEnd = value; 
      }) : refreshTrialDate()
    });
  }

  final DateFormat formatterDate = DateFormat('MMMM dd yyyy');
  final DateFormat formatterTime = DateFormat('Hm');

  @override
  Widget build(BuildContext context) {
    Globals.printDebug(inText: 'PaymentPage Building widget');

    Globals.subscriptionButtonText = 'Subscribe for ${Globals.monthlyProduct.priceString} / Month';
    Globals.bottomNavIndex = 3;

    final defaultColorScheme = Theme.of(context).colorScheme;
    // ThemeData(brightness: 

    return Scaffold(
      backgroundColor: defaultColorScheme.background,
      bottomNavigationBar: BottomNavWidget(selectExisting: true,),
      body: SingleChildScrollView( child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(width: double.infinity - 100, height: 70.0, child: Theme.of(context).brightness == Brightness.dark ? Image.asset('assets/images/aiseeklogoondark.png') : Image.asset('assets/images/aiseeklogo.png')),
                SizedBox(height: 30),
                SizedBox(
                    width: double.infinity - 100,
                    child: Center(
                        child: Text('Premium Plan',
                            textAlign: TextAlign.center, style: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2, fontWeight: FontWeight.w700)))),
                SizedBox(height: 10),
                SizedBox(
                    width: double.infinity - 100,
                    child: BulletList([
                      'You are currently enjoying a free trial of AI seek which will end on ' + formatterDate.format(freeTrialEnd) + ' at ' + formatterTime.format(freeTrialEnd) +'.',
                      'Your free trial limits you to to 3 image creations and 6 GPT-4 queries per day.',
                      'Your free trial will not automatically convert to a paid subscription and does not need to be cancelled, at the trial end date your access to the app features will end.',
                      'To get continuing access to our revolutionary AI-powered search application after your trial end date, or to access the full usage limits now, subscribe below.',
                      '${Globals.monthlyProduct.priceString}/month auto-renewing subscription. Cancel any time in ${Platform.isIOS ? 'App Store' : 'Google Play store.'}'
                    ])
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubscriptionButton(
                        storeProduct: Globals.monthlyProduct,
//                          key: Key(monthlyProduct.packageIdentifier)),
                        isSelected: _selectedPackage == Globals.monthlyProduct,
                        onSelected: (StoreProduct package) async {
                          setState(() {
                            _selectedPackage = package;
                            Globals.currentProduct = Globals.monthlyProduct;
                            Globals.subscriptionButtonText = 'Subscribe for ${Globals.monthlyProduct.priceString} / Month';
                          });
                        },
                      ),
                      if (AppConstants.debug_flag) SizedBox(width: 10),
                      if (AppConstants.debug_flag) SubscriptionButton(
                          storeProduct: Globals.annualProduct,
                          isSelected: _selectedPackage == Globals.annualProduct,
                          onSelected: (StoreProduct package) {
                            setState(() {
                              _selectedPackage = package;
                              Globals.currentProduct = Globals.annualProduct;
                              Globals.subscriptionButtonText = 'Subscribe for ${Globals.annualProduct.priceString} / Year';
                            });
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity - 100,
                  height: 50.0,
                  child: ElevatedButton(
                      child: Text(Globals.subscriptionButtonText),
                      style: Themes().subscribeButtonStyle(context),
                      onPressed: () async {
                        Globals.printDebug(inText: 'PaymentPage AISEEK-144 Subscription button tapped');
                        try {
                          await Purchases.purchaseStoreProduct(Globals.currentProduct);
                        } catch (e) {
                          Globals.printDebug(inText: 'SubscriptionButton Monthly Purchase Failed e = ${e.toString()}');
                        }
                      }),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Center(
                          child: TextButton(
                            child: Text('Restore purchase'),
                            onPressed: restorePurchases,
                          )
                        ),
                        !Platform.isIOS ? (
                          Center(
                            child: TextButton(
                              child: Text('Manage Subscription'),
                              onPressed: () {
                                context.push(context.namedLocation(AppConstants.genericWebviewRouteName,
                                    queryParameters: {'url': AppConstants.managesubAndroidURL, 'title': 'Manage Subscription', 'showBack': 'true'}));
                              },
                            )
                          )
                        ) : Text('')
                    ]),
                        
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
                                queryParameters: {'url': (Platform.isIOS)?AppConstants.termsOfUseURL: 'https://www.aiseek.ai/app-terms-of-use/', 'title': 'Terms of use', 'showBack': 'true'}));
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
    ),);
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      Globals.customerInfo = customerInfo;
      // ... check restored purchaserInfo to see if entitlement is now active
      checkEntitlement();
      setState(() {
        // Globals.paymentPageInitialText = AppConstants.paymentPageWaitText;
      });
    } on PlatformException catch (e) {
      // Error restoring purchases
      Globals.printDebug(inText: 'PaymentPage Restore Purchases Error = ${e.toString()}');
      setState(() {
        Globals.paymentPageInitialText = AppConstants.paymentPageInitialText;
      });
    }
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


class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Padding( 
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5.0), 
            child: 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        str,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(fontSize: AppConstants.paymentPageFontSize),
                      ),
                    ),
                  ),
                ],
              )
            );
        }).toList(),
      ),
    );
  }
}