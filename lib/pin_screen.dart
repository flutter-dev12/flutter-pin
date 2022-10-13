import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:test_flutter_app/pin_button.dart';
import 'package:test_flutter_app/pin_dot.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const PinScreenPage(title: 'Create a PIN');
  }
}

class PinScreenPage extends StatefulWidget {
  const PinScreenPage({super.key, required this.title});

  final String title;

  @override
  State<PinScreenPage> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreenPage> {
  String? _hashedPin;
  String currentPin = "";
  String initialPin = "";
  bool confirming = false;

  @override
  void initState() {
    super.initState();
    _loadSharedPrefs();
  }

  bool isNewUser() {
    return _hashedPin == null;
  }

  String? getPin() {
    return _hashedPin;
  }

  String hashPin(String pin) {
    return sha256.convert(utf8.encode(pin)).toString();
  }

  Future<void> _showPinSavedDialog(BuildContext context, bool success) {
    String resultText = success ? "PIN has been created!" : "PINs do not match.";
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('PIN Wizard'),
          content: Text(resultText),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentPin = "";
                });
              },
            ),
          ],
        );
      },
    );
  }

  setPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    String hashedPin = hashPin(pin);
    prefs.setString("pin_hashed", hashedPin);
    setState(() {
      _hashedPin = hashedPin;
      _showPinSavedDialog(context, true);
    });
  }

  addNumber(int number) {
    String oldPin = currentPin;
    if(oldPin.length >= 4) return;
    String newPin = oldPin + number.toString();
    setState(() {
      currentPin = newPin;

      if(currentPin.length >= 4) {
        if(!confirming) {
          initialPin = currentPin;
          confirming = true;
          currentPin = "";
        } else {
          if(currentPin == initialPin) {
            setPin(currentPin);
          } else {
            _showPinSavedDialog(context, false);
          }
        }
      }
    });
  }

  removeNumber() {
    String oldPin = currentPin;
    debugPrint(oldPin);
    if(oldPin.isEmpty) return;
    String newPin = oldPin.substring(0, oldPin.length - 1);
    debugPrint(newPin);
    setState(() {
      currentPin = newPin;
    });
  }

  _loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      debugPrint("LOADING PIN...");
      _hashedPin = prefs.getString("pin_hashed");
      debugPrint("Loaded hashed PIN: $_hashedPin");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String promptText = confirming ? "Confirm your PIN" : "Create a PIN";
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(promptText),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PinDot(position: 1, currentPin: currentPin),
                PinDot(position: 2, currentPin: currentPin),
                PinDot(position: 3, currentPin: currentPin),
                PinDot(position: 4, currentPin: currentPin),
              ]
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PinButton(number: 1, callback: addNumber),
                PinButton(number: 2, callback: addNumber),
                PinButton(number: 3, callback: addNumber)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PinButton(number: 4, callback: addNumber),
                PinButton(number: 5, callback: addNumber),
                PinButton(number: 6, callback: addNumber)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PinButton(number: 7, callback: addNumber),
                PinButton(number: 8, callback: addNumber),
                PinButton(number: 9, callback: addNumber)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 100, height: 100),
                PinButton(number: 0, callback: addNumber),
                SizedBox(width: 100, height: 100,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(64.0)
                                )
                            )
                        ),
                        onPressed: () => removeNumber(),
                        child: const Center(
                          child: Text("<",
                              style: TextStyle(color: Colors.black)),
                    )))
              ],
            )
          ],
        ),
      )
    );
  }
}