import 'dart:ui';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

// ignore: must_be_immutable
class NumPad extends StatelessWidget {
  Function enterAmount;
  NumPad(this.enterAmount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                mainAxisExtent: MediaQuery.of(context).size.height / 8 - 2,
              ),
              itemCount: 12,
              padding: EdgeInsets.all(0),
              itemBuilder: (ctx, index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () => enterAmount(numpadItems[index]),
                  child: Container(
                    color: numpadItems[index] == '.' ? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.5),
                    child: Center(
                      child: numpadItems[index] == '.'
                          ? Icon(Icons.check, size: 40)
                          : Text(numpadItems[index], style: kCurrencyAmountStyle.copyWith(fontSize: 35)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
