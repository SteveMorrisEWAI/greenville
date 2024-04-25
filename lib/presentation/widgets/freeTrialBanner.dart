import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';
import 'package:aiseek/core/utilities/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FreeTrialBanner extends StatefulWidget {

  const FreeTrialBanner({
    Key? key
  }) : super(key: key);

  @override
  State<FreeTrialBanner> createState() => _FreeTrialBannerState();
}

class _FreeTrialBannerState extends State<FreeTrialBanner>  {

  bool isLoading = true;
  DateTime freeTrialEnd = Globals.FreeTrialEndDate;

  // Future<double> getUsageMeter() async {
  //   UsageMeterProvider usageMeterProvider = UsageMeterProvider();
  //   double usageMeterReturn = await usageMeterProvider.getData();
  //   return usageMeterReturn;
  // }

  Future<DateTime> getTrialDate() async {
    var freeTrial = Globals.FreeTrialEndDate;
    await SharedPreferenceStorage.getFreeTrialExpiry().then((freeTrialExpiryString) => {
      freeTrial = DateTime.parse(freeTrialExpiryString)
    });
    return freeTrial;
  }

  

  @override
  void initState() {
    super.initState();
    
    refreshTrialDate();
    
  }

  final DateFormat formatterDate = DateFormat('MMMM dd yyyy');
  final DateFormat formatterTime = DateFormat('Hm');

  refreshTrialDate() async {
    await Future.delayed(const Duration(seconds: 2));
    getTrialDate().then((value) => {
      ( value.year != 2000) ? setState(() {
        freeTrialEnd = value; 
      }) : refreshTrialDate()
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();

    final defaultColorScheme = Theme.of(context).colorScheme;

    var banner = (!Globals.entitlementActive && freeTrialEnd.year != 2000) ? Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        width: deviceWidth,
        decoration: BoxDecoration(
          border: Border.all(
            color: defaultColorScheme.outline,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: defaultColorScheme.outline
        ),
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column( crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          freeTrialEnd.isAfter(now) ? 
            Text( 'You are currently using our free trial. Your free trial ends on ' + formatterDate.format(freeTrialEnd) + ' at ' + formatterTime.format(freeTrialEnd), textAlign: TextAlign.center, ) 
            :
            Text( 'Your free trial expired on ' + formatterDate.format(freeTrialEnd) + ' at ' + formatterTime.format(freeTrialEnd) + '. You need to upgrade to continue using the app.', textAlign: TextAlign.center, ),
          SizedBox(height: 5,),
          ElevatedButton(
              child: Text('Upgrade to our paid plan'),
              style: Themes().primaryButtonStyle(context),
              onPressed: () => context.push(context.namedLocation(AppConstants.paymentPageRouteName))
            ),
        ]),
      ) : SizedBox(width: 0, height: 0,);
    return banner;
  }
}