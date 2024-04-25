import 'package:purchases_flutter/purchases_flutter.dart';

class StoreConfig {
  final Store store;
  final String apiKey;
  final String appUserID;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey, required appUserID}) {
    _instance ??= StoreConfig._internal(store, apiKey, appUserID);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey, this.appUserID);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == Store.appStore;

  static bool isForGooglePlay() => instance.store == Store.playStore;

  static bool isForAmazonAppstore() => instance.store == Store.amazon;
}
