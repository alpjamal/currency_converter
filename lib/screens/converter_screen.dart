import 'package:flutter/material.dart';

import '../widgets/input_result.dart';
import '../widgets/numpad.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String userInput = '0';

  double totalAmount = 0.0;

  enterAmount(String amount) {
    setState(() {
      if (amount == 'C') {
        userInput = '0';
      } else {
        userInput += amount;
      }
      totalAmount = double.parse(userInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Inputs(totalAmount),
            NumPad(enterAmount),
          ],
        ),
      ),
    );
  }
}
