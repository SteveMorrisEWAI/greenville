import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/commons/app_constants.dart';
import '../../core/commons/globals.dart';

class SuggestionItem extends StatefulWidget {
  final String tipText;

  const SuggestionItem({
    Key? key,
    this.tipText = ''
  }) : super(key: key);

  @override
  State<SuggestionItem> createState() => _SuggestionItemState();
}

class _SuggestionItemState extends State<SuggestionItem>  {
  
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    final defaultColorScheme = Theme.of(context).colorScheme;
    const padding = 15.0;
    const iconWidth = 29.0;
    
    return 
    GestureDetector(
      onTap: () {
        Globals.currentPrompt = widget.tipText;
        Globals.hasGPTLoadingFinished.value = false;
        Globals.URLArray.initializeStack(inSource: 'PromptPage search button');
        Globals.generateImage = false;
        context.push(
          context.namedLocation(AppConstants.loadingWebPageRouteName),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: defaultColorScheme.outline,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
        child: Row(children: [
            ConstrainedBox( 
              constraints: BoxConstraints(maxWidth: deviceWidth - (padding*5) - iconWidth),
              child: Text(widget.tipText)
            ),
            Spacer(),
            Image.asset('assets/images/rightarrow.png', width: iconWidth,),
          ],
        )
        
      )
    );
  }
}
