import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/commons/app_constants.dart';
import '../../core/commons/globals.dart';

class BottomNavWidget extends StatefulWidget {

  final bool selectExisting;

  const BottomNavWidget({
    Key? key,
    this.selectExisting = true
  }) : super(key: key);

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget>  {
  int _selectedIndex =  Globals.bottomNavIndex;

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Globals.printDebug(inText: 'bottomNavIndex ${index != Globals.bottomNavIndex}');
    Globals.printDebug(inText: 'selectExisting ${!widget.selectExisting}');
    Globals.printDebug(inText: 'index == 3 ${index == 3}');
    if( index != Globals.bottomNavIndex || !widget.selectExisting || index == 3 ) {
      Globals.bottomNavIndex = index;
      switch(index) {
        case 1:
          return context.pushReplacementNamed(
            context.namedLocation(AppConstants.previousSearchesRouteName),
          );
        case 2:
          return context.pushReplacementNamed(AppConstants.genericWebviewRouteName, queryParameters: {'url': AppConstants.faqURL, 'title': 'Help & FAQs', 'showBack': 'false'});
        case 3:
          return context.pushReplacementNamed(
            context.namedLocation(AppConstants.settingsRouteName),
          );
        default:
          return context.pushReplacementNamed(
            context.namedLocation(AppConstants.promptPageRouteName),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = 6.0;
    const navpadding = EdgeInsets.all(padding);
    const navIconWidth = 42.00;
    final defaultColorScheme = Theme.of(context).colorScheme;

    if (!widget.selectExisting ) {
      setState(() {
        _selectedIndex = 0;
      });
    }
    
    return 
    Container(
      color: defaultColorScheme.secondaryContainer,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
        child: BottomNavigationBar(
            backgroundColor: defaultColorScheme.secondaryContainer,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 14.00,
            selectedFontSize: 14.00,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_home.png'),
                    padding: navpadding,
                  ),
                ),
                activeIcon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: (widget.selectExisting)? Image.asset('assets/images/bottomnav_home_active.png'):Image.asset('assets/images/bottomnav_home.png'),
                    padding: navpadding,
                  ),
                ),
                label:'Home',
                backgroundColor: defaultColorScheme.secondaryContainer,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_history.png'),
                    padding: navpadding,
                  ),
                ),
                activeIcon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_history_active.png'),
                    padding: navpadding,
                  ),
                ),
                label:'History',
                backgroundColor: defaultColorScheme.secondaryContainer,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_help.png'),
                    padding: navpadding,
                  ),
                ),
                activeIcon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_help_active.png'),
                    padding: navpadding,
                  ),
                ),
                label:'Help',
                backgroundColor: defaultColorScheme.secondaryContainer,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_settings.png'),
                    padding: navpadding,
                  ),
                ),
                activeIcon: Container(
                  width: navIconWidth,
                  height: navIconWidth,
                  child: Padding(
                    child: Image.asset('assets/images/bottomnav_settings_active.png'),
                    padding: navpadding,
                  ),
                ),
                label:'Settings',
                backgroundColor: defaultColorScheme.secondaryContainer,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: (widget.selectExisting)? Colors.white : defaultColorScheme.onSecondaryContainer,
            unselectedItemColor: defaultColorScheme.onSecondaryContainer,
            onTap: _onItemTapped,
          ),
      ),
    );
  }
}
