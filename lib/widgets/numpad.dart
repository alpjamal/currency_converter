import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';
import '../utilities/constants.dart';

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Currency>(context, listen: false);

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
              physics: ScrollPhysics(),
              itemCount: 12,
              padding: EdgeInsets.all(0),
              itemBuilder: (ctx, index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () => data.enterAmount(numpadItems[index]),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
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
