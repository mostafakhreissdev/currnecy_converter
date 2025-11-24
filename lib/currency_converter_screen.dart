import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String from = "USD";
  String to = "LBP";

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  final Map<String, Map<String, dynamic>> currencyData = {
    "USD": {"flag": "🇺🇸", "rate": 1.00},
    "EUR": {"flag": "🇪🇺", "rate": 0.87},
    "GBP": {"flag": "🇬🇧", "rate": 0.76},
    "JPY": {"flag": "🇯🇵", "rate": 156.87},
    "LBP": {"flag": "🇱🇧", "rate": 90000.0},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Currency Converter",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    initialValue: from,
                    decoration: const InputDecoration(labelText: "From"),
                    items: currencyData.keys.map((code) {
                      return DropdownMenuItem(
                        value: code,
                        child: Row(
                          children: [
                            Text(currencyData[code]!["flag"],
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(code),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        from = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: fromController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Amount"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    initialValue: to,
                    decoration: const InputDecoration(labelText: "To"),
                    items: currencyData.keys.map((code) {
                      return DropdownMenuItem(
                        value: code,
                        child: Row(
                          children: [
                            Text(currencyData[code]!["flag"],
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(code),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        to = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: toController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: "Converted"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  double input =
                      double.tryParse(fromController.text.trim()) ?? 0;

                  double usdValue = input / currencyData[from]!["rate"];
                  double output = usdValue * currencyData[to]!["rate"];

                  toController.text = output.toStringAsFixed(2);
                },
                child: const Text("Calculate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
