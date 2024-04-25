import 'package:flutter/material.dart';

import '../../core/commons/globals.dart';

class TipItem extends StatefulWidget {
  final String tipText;

  const TipItem({
    Key? key,
    this.tipText = ''
  }) : super(key: key);

  @override
  State<TipItem> createState() => _TipItemState();
}

class _TipItemState extends State<TipItem>  {
  
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    final defaultColorScheme = Theme.of(context).colorScheme;
    const padding = 10.0;
    const iconWidth = 19.0;
    
    return 
    Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: defaultColorScheme.outline,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: defaultColorScheme.outline
      ),
      padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
      child: Row(children: [
          Image.asset('assets/images/lightbulb.png', width: iconWidth,),
          // Spacer(flex: ,),
          SizedBox(width: 10),
          ConstrainedBox( 
            constraints: BoxConstraints(maxWidth: deviceWidth - (padding*5) - iconWidth - 10),
            child: Text(widget.tipText)
          )
        ],
      )
      
    );
  }
}
