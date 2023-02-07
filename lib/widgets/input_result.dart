import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import '../providers/currency_provider.dart';

class Inputs extends StatelessWidget {
  const Inputs({super.key});

  @override
  Widget build(BuildContext context) {
    final Currency data = Provider.of<Currency>(context, listen: false);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: FutureBuilder(
            future: data.getCurrencies(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.white));
              }
              return Consumer<Currency>(builder: (ctx, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Currency Converter', style: kCurrencyAmountStyle),
                    MyDropdownButton(
                      pickedCurrency: value.baseCurrency,
                      selectCurrency: value.selectBaseCurrency,
                      amount: value.totalAmount.toString(),
                      currencyData: value,
                      isLoading: false,
                    ),
                    MyDropdownButton(
                      pickedCurrency: value.targetCurrency,
                      selectCurrency: value.selectTargetCurrency,
                      amount: value.result.toStringAsFixed(1),
                      currencyData: value,
                      isLoading: value.isLoading,
                    ),
                  ],
                );
              });
            }),
      ),
    );
  }
}

class MyDropdownButton extends StatelessWidget {
  final String pickedCurrency;
  final Function selectCurrency;
  final String amount;
  final Currency currencyData;
  final bool isLoading;
  const MyDropdownButton({
    required this.pickedCurrency,
    required this.selectCurrency,
    required this.amount,
    required this.currencyData,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton(
          underline: SizedBox(),
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.white, fontSize: 25),
          value: pickedCurrency,
          items: currencyData.currencies.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: (value) => selectCurrency(value),
        ),
        Spacer(),
        if (isLoading) CircularProgressIndicator(color: Colors.white),
        if (!isLoading) Text(amount, style: kCurrencyAmountStyle),
      ],
    );
  }
}
