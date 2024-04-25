import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/themes.dart';
import 'package:aiseek/data/dataproviders/statement_provider.dart';
import 'package:aiseek/data/dataproviders/usage_meter_provider.dart';
import 'package:aiseek/data/models/statement_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UsageMeterWidget extends StatefulWidget {
  final bool alwaysShow;

  const UsageMeterWidget({
    Key? key,
    this.alwaysShow = false,
  }) : super(key: key);

  @override
  State<UsageMeterWidget> createState() => _UsageMeterWidgetState();
}

class _UsageMeterWidgetState extends State<UsageMeterWidget>  {

  double usage = 0;
  int bankTotal = 0;
  double usageWidth = 0;
  bool isLoading = true;

  Future<double> getUsageMeter() async {
    UsageMeterProvider usageMeterProvider = UsageMeterProvider();
    double usageMeterReturn = await usageMeterProvider.getData();
    return usageMeterReturn;
  }

  Future<StatementItem> getStatement() async {
    StatementItem data = await StatementProvider().getData();
    return data;
  }

  @override
  void initState() {
    super.initState();
    getUsageMeter().then((value) => {
      if( value == -100 && widget.alwaysShow) {
        context.push(context.namedLocation(AppConstants.paymentPageRouteName))
      } else {
        setState(() {
          usage = value; 
        }),
        getStatement().then((value) => setState(() {
          bankTotal = value.bank_total;
          isLoading = false;
        }))
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final defaultColorScheme = Theme.of(context).colorScheme;
    double deviceWidth = MediaQuery.of(context).size.width;
    double paddingH = 15.0;
    double pcMeterWidth = deviceWidth - (paddingH * 2) - 22;
    double pcWidth = pcMeterWidth / 100 * usage;

    Globals.printDebug(inText: 'Usage tokenPack Product  = ${Globals.tokenPack}');

    var usageRadiusStart = (usage == 100.0) ? BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ) : BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ) ;

    var usageRadiusEnd = (usage == 0.0) ? BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ) : BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          );

    var shouldShow = (usage > 80.0 && bankTotal <= 0);
    var usageMeter = (shouldShow || widget.alwaysShow) ? Container(
      margin: (widget.alwaysShow) ? const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0) : const EdgeInsets.only(bottom: 10.0),
      width: deviceWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: defaultColorScheme.outline,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: defaultColorScheme.background
      ),
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      child: isLoading ? SpinKitThreeBounce(
              color: defaultColorScheme.onBackground,
              size: 40.0,
            ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Usage', style: AppConstants.GeneralHeadingStyle),
          SizedBox( height: 5,),
          Row(children: [
            SizedBox(
              width: pcWidth,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: usageRadiusStart,
                  color: defaultColorScheme.primary
                ),
              ),
            ),
            SizedBox(
              width: pcMeterWidth - pcWidth,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: usageRadiusEnd,
                  color: defaultColorScheme.outline
                ),
              ),
            ),
          ],),
          SizedBox( height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Text('You have currently used ' + this.usage.toString() + '% of your monthly allowance.', textAlign: TextAlign.center),
          ]),
          SizedBox( height: 10,),
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            if (this.bankTotal > 0) Text('You have ' + this.bankTotal.toString() + ' tokens in your bank', textAlign: TextAlign.center),

            SizedBox( height: 3,),

            if( Globals.entitlementActive )
              ( widget.alwaysShow ) ?
                ElevatedButton(
                  child: Text('Top up'),
                  style: Themes().primaryButtonStyle(context),
                  onPressed: () async {
                    try {
                      await Purchases.purchaseStoreProduct(Globals.tokenPack).whenComplete(() => context.push(context.namedLocation(AppConstants.promptPageRouteName))) ;
                    } catch (e) {
                      Globals.printDebug(inText: 'Purchase Failed e = ${e.toString()}');
                    }
                  },
                )
              :
                ElevatedButton(
                  child: Text('View usage & top up'),
                  style: Themes().greyButtonStyle(context),
                  onPressed: () async {
                    context.push(context.namedLocation(AppConstants.usagePageRouteName));
                  },
                )
            
          ])
        ],
      )
    ): SizedBox(width: 0, height: 0,);  

    return usageMeter;
    
  }
}