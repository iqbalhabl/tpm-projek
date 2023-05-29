import 'package:flutter/material.dart';

const color1 = Colors.black;
const color2 = Colors.blue;
const color3 = Colors.white;

class ConversionPage extends StatefulWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

String convertCurrencies(
  String currency1,
  String currency2,
  String input,
) {
  double? doubleCurrency1 = double.tryParse(currency1);
  double? doubleCurrency2 = double.tryParse(currency2);
  double? doubleAmount = double.tryParse(input);

  if (doubleCurrency1 != null &&
      doubleCurrency2 != null &&
      doubleAmount != null) {
    double result = doubleAmount * doubleCurrency2 / doubleCurrency1;
    return result.toString();
  } else {
    return 'Invalid input';
  }
}

class _ConversionPageState extends State<ConversionPage> {
  final _inputValueController = TextEditingController();

  String firstCurrencyValue = "1";
  String secondCurrencyValue = "1";
  String convertedResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currencies')),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 300,
              child: TextFormField(
                controller: _inputValueController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: color1,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  fillColor: color2,
                  focusColor: color1,
                  hintText: 'Masukkan angka',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _firstDropdown(),
            _secondDropdown(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: color1,
                  backgroundColor: color2,
                  shadowColor: Colors.black,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(100, 50),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      convertedResult = convertCurrencies(
                        firstCurrencyValue,
                        secondCurrencyValue,
                        _inputValueController.text,
                      );
                    },
                  );
                },
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 5),
                const Text(
                  'Result : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  convertedResult,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstDropdown() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 300,
      child: DropdownButtonFormField<String>(
        value: firstCurrencyValue,
        items: dropdownItems,
        iconEnabledColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            firstCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: color1,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: color2,
          labelText: 'Currency 1',
          labelStyle: const TextStyle(
            color: color1,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _secondDropdown() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 300,
      child: DropdownButtonFormField<String>(
        value: secondCurrencyValue,
        items: dropdownItems,
        iconEnabledColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            secondCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: color1,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: color2,
          labelText: 'Currency 2',
          labelStyle: const TextStyle(
            color: color1,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: '1',
        child: Text("USD"),
      ),
      const DropdownMenuItem(
        value: '14859.295505',
        child: Text("IDR"),
      ),
      const DropdownMenuItem(
        value: '0.74',
        child: Text("SGD"),
      ),
    ];
    return menuItems;
  }
}
