import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionButton extends StatelessWidget {
  final StoreProduct storeProduct;
  final bool isSelected;
  final ValueChanged<StoreProduct> onSelected;

  SubscriptionButton({
    required this.storeProduct,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: ValueKey(storeProduct));

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth / 2.5;
    double cardHeight = cardWidth * 0.55;
    double fontSize = MediaQuery.of(context).textScaleFactor * 18;
    return GestureDetector(
      onTap: () {
        onSelected(storeProduct);
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.shadow,
          border: Border.all(
            color: isSelected ? Colors.pinkAccent : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: isSelected ? Colors.pinkAccent : Colors.white,
                  radius: fontSize * 0.7,
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: fontSize, // size of the check icon
                        )
                      : Container(), // Empty container when not selected
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Center(child:
                      Text(
                        storeProduct.title,
                        style: TextStyle(fontSize: fontSize / 2, color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    Center(child:
                      Text(
                        storeProduct.priceString,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    Center(child:
                      Text(
                        storeProduct.description,
                        style: TextStyle(fontSize: fontSize / 2, color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
