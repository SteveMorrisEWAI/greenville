import 'dart:convert';

class MyStoreProduct {
  String packageIdentifier;
  String title;
  String priceString;
  String productIdentifier;
  String packageDescription;

  MyStoreProduct({
    required this.packageIdentifier,
    required this.title,
    required this.priceString,
    required this.productIdentifier,
    required this.packageDescription,
  });

  // Converting a StoreProduct object into a Map
  Map<String, dynamic> toMap() {
    return {
      'packageIdentifier': packageIdentifier,
      'title': title,
      'priceString': priceString,
      'productIdentifier': productIdentifier,
      'packageDescription': packageDescription,
    };
  }

  // Constructing a StoreProduct object from a Map
  factory MyStoreProduct.fromMap(Map<String, dynamic> map) {
    return MyStoreProduct(
      packageIdentifier: map['packageIdentifier'],
      title: map['title'],
      priceString: map['priceString'],
      productIdentifier: map['productIdentifier'],
      packageDescription: map['packageDescription'],
    );
  }

  // Converting a StoreProduct object into a JSON string
  String toJson() {
    return jsonEncode(toMap());
  }

  // Constructing a StoreProduct object from a JSON string
  factory MyStoreProduct.fromJson(String source) {
    return MyStoreProduct.fromMap(jsonDecode(source));
  }
}
