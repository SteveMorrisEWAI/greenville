import 'package:aiseek/core/commons/app_constants.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:aiseek/business_logic/cubits/next_page_state.dart';
import 'package:aiseek/data/models/previous_search.dart';
import 'package:aiseek/core/utilities/url_stack.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class Globals {
// Revenue Cat Active flag
  static SharedPreferences? prefs;
  static bool entitlementActive = false;
  static EntitlementInfo? entitlement;
  static CustomerInfo? customerInfo;
  static Offerings? offerings;
//  static Product? product_monthly;

//  Device attributes
  static String AndroidMobileBrand = '';
  static String AndroidisPhysicalDevice = '';
  static String AndroidversionSdkInt = '';
  static String Androidmanufacturer = '';
  static String AndroidversionSecurityPatch = '';
  static String AndroidversionRelease = '';
  static String AndroidversionPreviewSdkInt = '';
  static String AndroidversionIncremental = '';
  static String AndroidversionCodename = '';
  static String Androidboard = '';
  static String Androidbootloader = '';
  static String Androiddisplay = '';
  static String Androidfingerprint = '';
  static String Androidhardware = '';
  static String Androidhost = '';
  static String Androidid = '';
  static String Androidproduct = '';
  static String AndroidsystemFeatures = '';
  static String IOSlocalizedModel = '';
  static String IOSidentifierForVendor = '';
  static String IOSisPhysicalDevice = '';
  static String IOSutsnameSysname = '';
  static String IOSutsnameNodename = '';
  static String IOSutsnameRelease = '';
  static String IOSutsnameVersion = '';
  static String IOSutsnameMachine = '';
  static String IOSsystemVersion = '';
  static String AndroidID = '';
  static String OriginalAppUserId = '';
  static int ClientInstallRetryCount = 0;
  static String lastPage = AppConstants.promptPageRouteName;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); //Create a key
  static bool traditionalLinks = false;
  static bool ClientCheck = false;
  static String versionNumber = AppConstants.noVersion;
  static String buildNumber = 'No build number yet';
  static bool myLogger = false;
  static String paymentPageInitialText = AppConstants.paymentPageInitialText;

  static StoreProduct monthlyProduct = new StoreProduct('Monthly', 'Paid Monthly', 'Premium Month (AI Seek)', 14.99, '\$14.99', 'USD');
  static StoreProduct annualProduct = new StoreProduct('Annual', 'Paid Annually', 'Premium Year (AI Seek)', 149.99, '\$149.99', 'USD');
  static StoreProduct currentProduct = new StoreProduct('NoPackage3', 'NoPackageDescription', 'NoTitle', 0.0, 'NoPriceString', 'NoCurrencyCode');
  static StoreProduct tokenPack = new StoreProduct('Token Pack', 'NoPackageDescription', 'NoTitle', 0.0, 'NoPriceString', 'NoCurrencyCode');

  static bool isMonthlySelected = false;
  static bool isAnnualSelected = false;
  static String subscriptionButtonText = AppConstants.subscriptionButtonText;

  bool SetSelectedSubscription({required String packageIdentifier}) {
    if (packageIdentifier == 'Monthly') {
      isMonthlySelected = !isMonthlySelected;
      if (isMonthlySelected) {
        isAnnualSelected = false;
      }
      return isMonthlySelected;
    }
    isAnnualSelected = !isAnnualSelected;
    if (isAnnualSelected) {
      isMonthlySelected = false;
    }
    return isAnnualSelected;
  }
//  static bool entitlementActive = false;

// Stored Uri's
  static Map<String, dynamic> currentBody = jsonDecode('{page_url: "https://static.aiseek.ai/20237771757134572_st_134585.html"');
  static String searchJsonArray = '''
  [
  {
    "conv_id": "30c8dd63-ad4b-40c7-8573-dadbc90108f8_dc34b",
    "created": "2023-04-21T05:39:03.291479",
    "prompt": "Tell me all about Thomas Telford",
    "page_url": "https://nonprod-nlp.s3.eu-west-2.amazonaws.com/20234215393678556.html",
    "total_tokens": 92
  },
  {
    "conv_id": "30c8dd63-ad4b-40c7-8573-dadbc90108f8_3e47e",
    "created": "2023-04-21T05:39:50.694810",
    "prompt": "Tell me all about thomas Telford",
    "page_url": "https://nonprod-nlp.s3.eu-west-2.amazonaws.com/202342153953561892.html",
    "total_tokens": 590
  }  ]
  ''';
  static Map<String, dynamic> currentSearches = jsonDecode(searchJsonArray);

  static URLStack URLArray = URLStack();

  static Uri previousSearchUri = Uri();
  static Uri deletePreviousSearchUri = Uri();
  static Uri deleteAllSearchesUri = Uri();
  static Uri appHintUri = Uri();
  

//  Stored attributes
  static String Guid = AppConstants.nullGuid;
  static String AppSharePageURL = '';
  static int InstallTimeZone = 0;
  static String InstallIP = '255.255.255';
  static String myIP = '255.255.255.255';
  static String myDevice = 'myDevice';
  static String myModel = 'MyModel';
  static String myDeviceOS = 'myDeviceOS';
  static String PrivacyPolicyURL = 'myPrivacyPolicyURL';
  static int MessageDisplayLimit = -1;
  static int FreeTrialLength = -1;
  static DateTime FreeTrialEndDate = DateTime(2000, 01, 01);
  static bool isFreeTrialNull = false;
  static String jsonOrganisationsString = '';
  static String currentOutputFlag = 'WP';
  static String currentPrompt = "";
  static String currentHTMLPage = "";
  static String initialHTMLPage = "";
  static String currentShareHTMLPage = "";
  static String currentStaticHTMLPage = "";
  static String currentLoadedPage = "";
  static int currentWebViewDepth = 0;
  static bool wikipediaFlag = false;
  static int paymentPageCount = 0;
  static int addCustomerInfoUpdateListenerCount = 0;
  static String appUserID = '';
  static List<String> logData = [];
  static int bottomNavIndex = 0;
  static bool generateImage = false;

//Startup flag

//Loading GPT Listener flag
  static ValueNotifier<bool> hasGPTLoadingFinished = ValueNotifier<bool>(false);

  static NextPageState newState = NextPageState(nextPageState: AppConstants.promptPageRouteName);

  // Standard Colors
  static Color primaryColor = Color(0xFFC70043);
  static Color backgroundColorLightTheme = Colors.white;
  static Color textColorLightTheme = Colors.black;


  static Color? stdBackgroundColor = endGradient;
  static Color stdForegroundColor = Colors.white;
  static Color? stdDisabledBackgroundColor = Color.fromARGB(255, 240, 226, 243);
  static Color stdDisabledForegroundColor = const Color.fromARGB(137, 119, 119, 119);
  static Color startGradient = Color(0xFF450044);
  static Color endGradient = Color(0xFFC70043);
  static Color grayBackgroundColor = Colors.white10;
  static Color grayForegroundColor = Colors.black54;
  static Color grayDisabledBackgroundColor = Color.fromARGB(31, 220, 220, 220);
  static Color bottomNavBackground = Color.fromARGB(255, 40, 40, 40);
  static Color bottomNavTextColour = Color.fromARGB(255, 156, 156, 156);
  static Color boxBgColour = Color.fromARGB(255, 241, 241, 241);
  static Color boxBorderColour = Color.fromARGB(255, 219, 219, 219);

  // Current Objects
  static PreviousSearch currentPreviousSearch =
      PreviousSearch(conv_id: 'myConvId', created: DateTime.now(), prompt: 'myPrompt', page_url: 'myPage_url', share_url: 'myShare_url');

  static ButtonStyle flatButtonStyleGrey = TextButton.styleFrom(
    elevation: 0,
    foregroundColor: grayForegroundColor,
    backgroundColor: grayBackgroundColor,
    disabledForegroundColor: grayForegroundColor,
    disabledBackgroundColor: grayBackgroundColor,
    maximumSize: Size(200, 40),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    textStyle: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2, fontWeight: FontWeight.bold),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
  );

// Orientation and device characteristics
  static bool isPortrait = true;
  static bool isMobile = true;
  static int shortestSide = 0;
  static int longestSide = 0;

// Debugging
  static String setLastPage(String newPage) {
    String oldPage = lastPage;
    lastPage = newPage;
    Globals.printDebug(inText: 'From $newPage, LastPage was = $oldPage, New Page is $newPage');
    return oldPage;
  }

  static void printDebug({required String inText}) {
    if (!AppConstants.debug_flag) {
      return;
    }
    if (AppConstants.logger_flag) {
      AddLog(inString: inText);
    }
    print(inText);
  }

  static void exitFunc(context) {
    Globals.printDebug(inText: 'Start exit Func');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App aiseek'),
        content: const Text('If you want to exit tap "OK" '),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (Platform.isIOS) {
                Globals.printDebug(inText: 'Exit IOS');
                // FlutterExitApp.exitApp(iosForceExit: true);
              } // force exit in ios
              else {
                Globals.printDebug(inText: 'Exit Anything else ');
                // FlutterExitApp.exitApp();
              }
            },
          ),
        ],
      ),
    );
  }

  static BoxDecoration myBoxDecoration = BoxDecoration(
    gradient: myLinearGradient,
  );

  static LinearGradient myLinearGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [startGradient, endGradient],
  );
  static void ClearLog() {
    logData = [];
  }

  static void AddLog({required String inString}) {
    if (logData.length > 5000) {
      logData.removeAt(0);
    }
    logData.add(inString);
  }
}
