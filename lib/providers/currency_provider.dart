import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utilities/constants.dart';

class Currency extends ChangeNotifier {
  final List<String> _currencies = [];

  String userInput = '0';
  int totalAmount = 0;
  double result = 0.0;
  bool isLoading = false;

  String baseCurrency = 'USD';
  String targetCurrency = 'UZS';

  List<String> get currencies => [..._currencies];

  Future getCurrencies() async {
    final url = Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/usd');
    final res = await http.get(url);
    final Map currencies = json.decode(res.body)['conversion_rates'];
    currencies.forEach((key, value) {
      _currencies.add(key);
    });
    notifyListeners();
  }

  enterAmount(String amount) {
    if (amount == '.') {
      convert();
    } else if (amount == 'C') {
      userInput = '0';
    } else if (amount != '.') {
      userInput += amount;
    }
    totalAmount = int.parse(userInput);
    notifyListeners();
  }

  Future<void> convert() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/pair/$baseCurrency/$targetCurrency/$totalAmount');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      result = double.parse(json.decode(response.body)['conversion_result'].toString());
      isLoading = false;
      notifyListeners();
    }
  }

  selectBaseCurrency(String selectedCurrency) {
    baseCurrency = selectedCurrency;
    notifyListeners();
  }

  selectTargetCurrency(String selectedCurrency) {
    targetCurrency = selectedCurrency;
    notifyListeners();
  }
}
