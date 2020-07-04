import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<DropdownMenuItem> dropDownButtonListItem() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  DropdownButton<String> androidDropButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownButtonListItem(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          for (String cryptoCoin in cryptoList) {
            getCurrencyPrice(cryptoCoin);
          }
        });
      },
    );
  }

  List<Text> pickerItems = [];
  List<Text> pickerItemList() {
    for (var currency in currenciesList) {
      String crncy = currency;
      pickerItems.add(Text(crncy));
    }
    return pickerItems;
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 26,
      onSelectedItemChanged: (value) {
        setState(() {});
      },
      children: pickerItemList(),
    );
  }

  String selectedCurrency = 'USD';
  String bitCoin = 'BTC';
  String usdPrice;
  String apiKey = '8C3EB7D6-49A8-4A6F-A664-11E3D631E369';
  String url = 'https://rest.coinapi.io/v1/exchangerate/';

  Future getCurrencyPrice(String cryptoCoin) async {
    bitCoin = cryptoCoin;
    http.Response response =
        await http.get('$url$bitCoin/$selectedCurrency?apikey=$apiKey');
    print(response.statusCode); //to confirm if api is working

    dynamic decodedData = jsonDecode(response.body);
    print(decodedData);
    setState(() {
      usdPrice = decodedData['rate'].toStringAsFixed(2);
    });
    print(usdPrice);
  }

  @override
  void initState() {
    super.initState();
    for (String cryptoCoins in cryptoList) {
      getCurrencyPrice(cryptoCoins);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $bitCoin = $usdPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $bitCoin = $usdPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $bitCoin = $usdPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropButton(),
          ),
        ],
      ),
    );
  }
}
