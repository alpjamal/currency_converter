import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../utilities/constants.dart';

class Inputs extends StatefulWidget {
  final double totalAmount;
  const Inputs(this.totalAmount, {super.key});

  @override
  State<Inputs> createState() => _InputsState();
}

List<String> currencies = [];

class _InputsState extends State<Inputs> {
  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  getCurrencies() async {
    final url = Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/usd');
    final res = await http.get(url);
    final Map result = json.decode(res.body)['conversion_rates'];
    result.forEach((key, value) {
      currencies.add(key);
    });
    setState(() {});
  }

  String baseCurrency = 'USD';
  String targetCurrency = 'UZS';
  double result = 0.0;
  bool isLoading = false;

  selectBaseCurrency(String selectedCurrency) {
    setState(() {
      baseCurrency = selectedCurrency;
    });
  }

  selectTargetCurrency(String selectedCurrency) {
    setState(() {
      targetCurrency = selectedCurrency;
    });
  }

  Future convert() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$apiKey/pair/$baseCurrency/$targetCurrency/${widget.totalAmount}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        result = double.parse(json.decode(response.body)['conversion_result'].toString());
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Currency Converter', style: kCurrencyAmountStyle),
            ),
            MyDropdownButton(baseCurrency, selectBaseCurrency,
                child: Text(
                  widget.totalAmount.toString(),
                  style: kCurrencyAmountStyle,
                )),
            IconButton(onPressed: () => convert(), icon: Icon(FontAwesomeIcons.rotate), iconSize: 40),
            MyDropdownButton(
              targetCurrency,
              selectTargetCurrency,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      result.toStringAsFixed(1),
                      style: kCurrencyAmountStyle,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDropdownButton extends StatelessWidget {
  final String selectedCurrency;
  final Function selectCurrency;
  final Widget child;
  const MyDropdownButton(this.selectedCurrency, this.selectCurrency, {required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton(
          underline: SizedBox(),
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.white, fontSize: 25),
          value: selectedCurrency,
          items: currencies
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: (value) {
            selectCurrency(value);
          },
        ),
        Spacer(),
        child,
      ],
    );
  }
}
