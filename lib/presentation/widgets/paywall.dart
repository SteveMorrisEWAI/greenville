import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/revenue_cat_model.dart';
import 'package:provider/provider.dart';
import 'package:aiseek/core/commons/globals.dart';

class Paywall extends StatefulWidget {
  final Offering offering;

  const Paywall({Key? key, required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(color: AppConstants.paywallBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
              child: const Center(child: Text('AI Seek Premium', style: AppConstants.paywallTitleTextStyle)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  'AI SEEK PREMIUM',
                  style: AppConstants.paywallDescriptionTextStyle,
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: Colors.black,
                  child: ListTile(
                      onTap: () async {
                        try {
                          CustomerInfo customerInfo = await Purchases.purchasePackage(myProductList[index]);
                          RevenueCatModel revenueCatModel = Provider.of<RevenueCatModel>(context, listen: false);
                          revenueCatModel.revenueCatActive = customerInfo.entitlements.active.isNotEmpty;
                          EntitlementInfo? entitlement = customerInfo.entitlements.all[AppConstants.entitlementID];
                          Globals.entitlementActive = entitlement?.isActive ?? false;
                        } catch (e) {
                          Globals.printDebug(inText: e.toString());
                        }

                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: Text(
                        myProductList[index].storeProduct.title,
                        style: AppConstants.paywallTitleTextStyle,
                      ),
                      subtitle: Text(
                        myProductList[index].storeProduct.description,
                        style: AppConstants.paywallDescriptionTextStyle.copyWith(fontSize: AppConstants.fontSizeSuperSmall),
                      ),
                      trailing: Text(myProductList[index].storeProduct.priceString, style: AppConstants.paywallTitleTextStyle)),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  AppConstants.footerText,
                  style: AppConstants.paywallDescriptionTextStyle,
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
