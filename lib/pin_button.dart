import 'package:flutter/material.dart';

class PinButton extends StatelessWidget {
  final int number;
  final Function(int) callback;

  const PinButton({Key? key, required this.number, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64.0)
                    )
                )
            ),
            onPressed: () => callback(number),
            child: Center(
              child: Text("$number",
                  style: const TextStyle(color: Colors.black)),
            )
        )
    );
  }
}