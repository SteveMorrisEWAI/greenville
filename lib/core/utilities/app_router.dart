import 'package:aiseek/core/utilities/check_free_trial.dart';
import 'package:aiseek/presentation/pages/devices_page.dart';
import 'package:aiseek/presentation/pages/generic_webview.dart';
import 'package:aiseek/presentation/pages/intro_page.dart';
import 'package:aiseek/presentation/pages/link_device_page.dart';
import 'package:aiseek/presentation/pages/usage_page.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/presentation/pages/loading_webview_page.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/presentation/pages/splash_page.dart';
import 'package:aiseek/presentation/pages/error_route_page.dart';
import 'package:aiseek/presentation/pages/error_page.dart';
import 'package:aiseek/presentation/pages/device_info_page.dart';
import 'package:aiseek/presentation/pages/results_page.dart';
import 'package:aiseek/presentation/pages/previous_searches_page.dart';
import 'package:aiseek/presentation/pages/prompt_page.dart';
import 'package:aiseek/presentation/pages/settings_page.dart';
import 'package:aiseek/presentation/pages/payment_page.dart';
import 'package:aiseek/presentation/pages/loading_page.dart';
import 'package:aiseek/presentation/pages/product_page.dart';
import 'package:aiseek/business_logic/cubits/next_page_cubit.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class AppRouter {
  final NextPageCubit nextPageCubit;
  final Key myKey = Key('AppRouter');
  AppRouter(this.nextPageCubit);
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: AppConstants.rootRouteName,
    routes: [
      GoRoute(
        name: AppConstants.promptPageRouteName,
        path: AppConstants.promptPageRouteName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: PromptPage(key: myKey, errorMessage: state.uri.queryParameters['errorMessage']?? ''),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        name: AppConstants.splashRouteName,
        path: AppConstants.splashRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SplashPage(key: myKey),
        ),
      ),
      GoRoute(
        name: AppConstants.resultsRouteName,
        path: AppConstants.resultsRouteName,
        redirect: (context, state) { 
          if (Globals.entitlementActive || CheckFreeTrial.isFreeTrialActive()) {
            return null;
          } else {
            Globals.printDebug(inText: 'AppRouter resultsRouteName no entitlement = ${Globals.entitlementActive.toString()} off to productPage');
            return AppConstants.paymentPageRouteName;
            // return AppConstants.productPageRouteName;
          }
        },
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ResultsPage(key: Key(UniqueKey().hashCode.toString())),
        ),
      ),
      GoRoute(
        name: AppConstants.deviceInfoRouteName,
        path: AppConstants.deviceInfoRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: DeviceInfoPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.loadingRouteName,
        path: AppConstants.loadingRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoadingPage(key: myKey),
        ),
      ),
      GoRoute(
        name: AppConstants.productPageRouteName,
        path: AppConstants.productPageRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ProductPage(key: myKey),
        ),
      ),
      GoRoute(
        name: AppConstants.previousSearchesRouteName,
        path: AppConstants.previousSearchesRouteName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: PreviousSearchesPage(key: myKey),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        name: AppConstants.paymentPageRouteName,
        path: AppConstants.paymentPageRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: PaymentPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.introPageRouteName,
        path: AppConstants.introPageRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: IntroPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.loadingWebPageRouteName,
        path: AppConstants.loadingWebPageRouteName,
        redirect: (context, state) {
          Globals.printDebug(inText: "AppRouter redirect");
          getEntitlement();

          if (Globals.hasGPTLoadingFinished.value) {
            return AppConstants.resultsRouteName;
          } else if (Globals.entitlementActive || CheckFreeTrial.isFreeTrialActive() || Globals.isFreeTrialNull ) {
            return AppConstants.loadingWebPageRouteName;
          } else {
            Globals.printDebug(inText: 'AppRouter Redirect state = ${state.toString()} off to payment page');
            return AppConstants.paymentPageRouteName;
          }

        },
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoadingWebViewPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.settingsRouteName,
        path: AppConstants.settingsRouteName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: SettingsPage(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        name: AppConstants.devicesRouteName,
        path: AppConstants.devicesRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: DevicesPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.linkDeviceRouteName,
        path: AppConstants.linkDeviceRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LinkDevicePage(),
        ),
      ),
      GoRoute(
        name: AppConstants.usagePageRouteName,
        path: AppConstants.usagePageRouteName,
        redirect: (context, state) {
          Globals.printDebug(inText: "AppRouter redirect");
          getEntitlement();

          if (Globals.entitlementActive || CheckFreeTrial.isFreeTrialActive() || Globals.isFreeTrialNull ) {
            return AppConstants.usagePageRouteName;
          } else {
            Globals.printDebug(inText: 'AppRouter Redirect state = ${state.toString()} off to payment page');
            return AppConstants.paymentPageRouteName;
          }

        },
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: UsagePage(errorMessage: state.uri.queryParameters['errorMessage']?? ''),
        ),
      ),
      GoRoute(
        name: AppConstants.genericWebviewRouteName,
        path: AppConstants.genericWebviewRouteName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: GenericWebviewPage(url: state.uri.queryParameters['url']!, title: state.uri.queryParameters['title']!, showBack: state.uri.queryParameters['showBack']!,),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        name: AppConstants.errorPageRouteName,
        path: AppConstants.errorPageRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ErrorPage(),
        ),
      ),
      GoRoute(
        name: AppConstants.navigationErrorRouteName,
        path: AppConstants.navigationErrorRouteName,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ErrorRoutePage(),
        ),
      ),
      GoRoute(
        name: AppConstants.rootRouteName,
        path: '/',
        redirect: (context, state) {
          getEntitlement();

          if (Globals.entitlementActive || CheckFreeTrial.isFreeTrialActive() || Globals.isFreeTrialNull ) {
            Globals.printDebug(inText: 'AppRouter Redirect state = ${state.toString()} off to promptPage');
            return AppConstants.promptPageRouteName;
          } else {
            // if(Globals.isFreeTrialNull) {
            //   Globals.printDebug(inText: 'AppRouter Redirect state = ${state.toString()} off to introPage');
            //   return AppConstants.introPageRouteName;
            // } else {
              Globals.printDebug(inText: 'AppRouter Redirect state = ${state.toString()} off to payment page');
              return AppConstants.paymentPageRouteName;
            // }
          }
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      Globals.printDebug(inText: "AppRouter errorPageBuilder state = $state");
      return MaterialPage<void>(
        key: state.pageKey,
        child: ErrorRoutePage(error: state.error),
      );
    },
  );
  Future<dynamic> getEntitlement() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    Globals.entitlementActive = customerInfo.entitlements.active.isNotEmpty;
    Globals.printDebug(inText: 'AppRouter getEntitlement()  Globals.entitlementActive = ${Globals.entitlementActive.toString()}');
    return true;
  }
}
