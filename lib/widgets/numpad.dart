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
            color: Colors.black.withOpacity(0.5),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: MediaQuery.of(context).size.height / 8,
              ),
              itemCount: 12,
              padding: EdgeInsets.all(0),
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    enterAmount(numpadItems[index]);
                  },
                  child: Center(
                    child: Text(
                      numpadItems[index],
                      style: TextStyle(color: Colors.white, fontSize: 35),
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
