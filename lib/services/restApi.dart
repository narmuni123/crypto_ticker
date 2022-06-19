
import 'dart:convert';
import 'package:crypto_ticker/constant/urls_Data.dart';
import 'package:crypto_ticker/model/crypto_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}