import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInfo {
  final String name;
  final int price;

  ProductInfo(this.name, this.price);
}

final products = [
  ProductInfo('Điện thoại iphone 7', 10),
  ProductInfo('Điện thoại iphone 8', 20),
  ProductInfo('Điện thoại iphone XS', 30),
  ProductInfo('Điện thoại iphone XS MAX', 40),
  ProductInfo('Điện thoại iphone 11 Pro Max', 50)
];

class NameYourPricePage extends StatefulWidget {
  const NameYourPricePage({Key? key}) : super(key: key);

  @override
  State<NameYourPricePage> createState() => _NameYourPricePageState();
}

class _NameYourPricePageState extends State<NameYourPricePage> {
  int _currentProductIndex = 0;
  int? _inputtedPrice;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            Text(products[_currentProductIndex].name),
            const Padding(padding: EdgeInsets.only(top: 10)),
            SizedBox(
              width: 200,
              child: TextField(
                key: const Key('priceInput'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  _inputtedPrice = int.tryParse(value);
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result =
                      _inputtedPrice == products[_currentProductIndex].price
                          ? 'pass'
                          : 'fail';
                });
              },
              child: const Text('Check'),
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: Text(
                _result,
                key: const Key('result'),
              ),
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentProductIndex < 4) _currentProductIndex++;
                    _result = '';
                  });
                },
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
