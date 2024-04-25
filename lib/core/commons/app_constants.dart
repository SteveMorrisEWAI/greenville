import 'package:flutter/material.dart';

class AppConstants {
  static const bool debug_flag = false; //Set to false for production
  static const bool logger_flag = true;
  static const String Brand_id = 'org_jbLmTuorietnQa6L'; // AI Seek
  static const double paymentPageFontSize = 14;
  static const String paymentPageInitialText =
      'Enjoy your free trial of AI Seek? Choose a subscription option below to get continuing access to our revolutionary AI-powered search application.';
  static const String paymentPageWaitText =
      'Select your preferred subscription option from those displayed below. There may be some slight delays while the option is processed securely, but be patient, your premium access is on its way!';

  // static const String uriAuthority = 'aiseek.development.nonprodsvc.com'; //Development
  static const String uriAuthority = 'aiseek.production.prodsvc.com'; //Production
  static const String uriUuidPath = '/v1/client/client-uuid';
  static const String uriClientUpdatePath = '/v1/client/client-update';
  static const String uriClientCheckPath = '/v1/client/check-client';
  static const String gptResultPath = '/v1/client/gpt-result';
  static const String previousSearchesPath = '/v1/client/client-conversations';
  static const String deleteSearchesPath = '/v1/client/client-search';
  static const String searchSearchesPath = '/v1/client/search-in-history';
  static const String deleteAllSearchesPath = '/v1/client/clear-searches';
  static const String appHintsPath = '/v1/client/app-hints';
  static const String referralPath = '/v1/client/referrer';
  static const String registerDevicePath = '/v1/client/app-device';
  static const String registeredDevicesPath = '/v1/client/client-devices';
  static const String usageMeterPath = '/v1/client/client-usage';
  static const String statementPath = '/v1/client/statement';
  static const String freeTrialEndPath = '/v1/client/free-trial-end';
  static const String deleteDevicePath = '/v1/client/registered-device';
  static const String appTitle = 'AI Seek';
  static const String splashPageTitle = 'AI Seek Splash Screen';
  static const String promptPageTitle = 'AI Seek';
  static const String resultsPageTitle = 'AI Seek Results';
  static const String previousSearchesResultsTitle = 'History';
  static const String settingsPageTitle = 'AI Seek Settings';
  static const String deviceInfoPageTitle = 'AI Seek Device Info';
  static const String errorPageTitle = 'Dart Error';
  static const String navigationErrorPageTitle = 'Navigation error';
  static const String loadingWebViewPageTitle = 'Processing prompt...';
  static const String paymentPageTitle = 'Subscription Payments';
  static const String ProductPageTitle = 'Product Description';
  static const String brandEmail = "info@brightonapp.com";
  static const String nullGuid = 'NullGuid';
  static const String noVersion = 'No version number';
  static const String subscriptionButtonText = 'Subscribe';
  static const String guidRef = 'Guid';
  static const int noMessageDisplayLimit = -1;
  static const String myDeviceRef = 'myDevice';
  static const String myDevice = 'myDevice ';
  static const String myModel = 'myModel ';
  static const String AppSharePageURL = 'AppSharePageURL';
  static const String InstallTimeZone = 'InstallTimeZone';
  static const String myDeviceOS = 'myDeviceOS ';
  static const String PrivacyPolicyURL = 'PrivacyPolicyURL ';
  static const String ProductPageURL = 'https://ethicalweb.ai/app-description/';
  static const String MessageDisplayLimit = 'MessageDisplayLimit ';
  static const String FreeTrialLength = 'FreeTrialLength ';
  static const String entitlementActiveRef = 'entitlementActive';
  static const String InstallIP = 'InstallIP ';
  static const String clientUuidRef = 'client_uuid';
  static const String clientUpdateRef = 'client_update';
  static const String clientCheckRef = 'client_check';
  static const String GPTResultRef = 'gpt-result';
  static const String previousSearchRef = 'previous_search';
  static const String deletePreviousSearchRef = 'client-search';
  static const String paymentPageRef = 'payment-page';
  static const String deleteAllSearches = 'clear-searches';
  static const String appHints = 'app-hints';
  static const String referral = 'referrer';
  static const Map<String, String> headerJson = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static const String resultErrorURL = 'https://s3.eu-west-2.amazonaws.com/stream.aiseek.ai/puberror.html';
  static const String arrayStringItemNotFound = 'Array String item not found';
  static const Color settingsBackgroundColor = Colors.white;
  static const Color settingsObjectColor = Colors.black;
  static const Color paywallBackgroundColor = Colors.black;
  static const Color paywallColorText = Colors.white;
  // static const Color subscriptionButtonText = Colors.white;
  // static const Color subscriptionButtonBackground = Colors.black;
  // static const Color subscriptionButtonBorderColor = Colors.blueAccent;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeNormal = 16.0;
  static const double fontSizeSuperSmall = 10.0;

  static const paywallTitleTextStyle = TextStyle(
    color: paywallColorText,
    fontWeight: FontWeight.bold,
    fontSize: fontSizeMedium,
  );

  static const paywallDescriptionTextStyle = TextStyle(
    color: paywallColorText,
    fontWeight: FontWeight.normal,
    fontSize: fontSizeNormal,
  );

  static const GeneralHeadingStyle = TextStyle(
    fontSize: AppConstants.paymentPageFontSize + 4,
    fontWeight: FontWeight.w700,
  );

  static const String privacyPolicyURL = 'https://www.ethicalweb.ai/app-privacy-policy/';
  static const String disclaimerURL = 'https://www.ethicalweb.ai/app-disclaimer';
  static const String faqURL = 'https://www.ethicalweb.ai/app-help-faqs';
  static const String termsOfUseURL = 'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';
  static const String managesubAndroidURL = 'https://play.google.com/store/account/subscriptions';
  //Route names
  static const String rootRouteName = '/';
  static const String promptPageRouteName = '/prompt';
  static const String splashRouteName = '/splash';
  static const String resultsRouteName = '/results';
  static const String deviceInfoRouteName = '/device_info';
  static const String previousSearchesRouteName = '/previous_searches';
  static const String settingsRouteName = '/settings';
  static const String devicesRouteName = '/devices';
  static const String linkDeviceRouteName = '/link_device';
  static const String genericWebviewRouteName = '/generic_webview';
  static const String errorPageRouteName = '/error_page';
  static const String navigationErrorRouteName = '/error_route';
  static const String loadingRouteName = '/loading';
  static const String loadingWebPageRouteName = '/loading_webview';
  static const String reloadResultsPageRouteName = '/reload_results';
  static const String paymentPageRouteName = '/payment_page';
  static const String introPageRouteName = '/intro_page';
  static const String productPageRouteName = '/product_page';
  static const String usagePageRouteName = '/usage_page';
  static const String defaultOutputFlag = 'WP';
//End Route names

// Revenue Cat statics
  static const String entitlementID = 'premium';
  static const String footerText = '** A purchase will be applied to your account of the amount selected  **';
  static const String appleApiKey = 'appl_CBMpANrUCuZlmEbhKQFUmMfGsHR';
  static const String googleApiKey = 'goog_nhcGMaBqhIHLBjdTKAsCgUUQiNv';
  static const String PremiumYear = 'rc_premium_year';
  static const String PremiumMonth = 'rc_premium_month';
}
