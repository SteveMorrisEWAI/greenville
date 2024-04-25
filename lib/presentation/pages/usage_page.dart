
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/data/dataproviders/statement_provider.dart';
import 'package:aiseek/data/models/statement_item.dart';
import 'package:aiseek/presentation/widgets/bottom_navigation.dart';
import 'package:aiseek/presentation/widgets/usage_meter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsagePage extends StatefulWidget {
  final String errorMessage;

  UsagePage({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  UsagePageState createState() => UsagePageState();
}

Future<StatementItem> statementFuture = getStatement();

Future<StatementItem> getStatement() async {
  StatementItem data = await StatementProvider().getData();
  return data;
}

class UsagePageState extends State<UsagePage> {

  @override
  Widget build(BuildContext context) {
    final defaultColorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text('Usage', style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: defaultColorScheme.onBackground),
          onPressed: () {
            return context.pop();
          },
        ),
      ),
      bottomNavigationBar: BottomNavWidget(),


      /// Spinner with multiple colors and custom shape
      body: Container(
        color: defaultColorScheme.background,
        child: Column(children: [ 
            if (widget.errorMessage != '') Text(widget.errorMessage, style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
            if (widget.errorMessage != '') SizedBox(height: 10,),
            UsageMeterWidget(alwaysShow: true,),

        ],)
      )
    );
  }

}
