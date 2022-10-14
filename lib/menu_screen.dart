import 'package:flutter/material.dart';
import 'package:test_flutter_app/pin_screen.dart';
import 'package:test_flutter_app/pin_screen_auth.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,
      ),
      home: const MenuScreenPage(title: 'Navigate'),
    );
  }
}

class MenuScreenPage extends StatefulWidget {
  const MenuScreenPage({super.key, required this.title});

  final String title;

  @override
  State<MenuScreenPage> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  navigate(StatelessWidget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () { navigate(const PinScreen()); },
                child: const Text('Create a PIN', style: TextStyle(fontSize: 20))
            ),
            ElevatedButton(
                onPressed: () { navigate(const PinScreenAuth()); },
                child: const Text('Authorize PIN', style: TextStyle(fontSize: 20))
            )
          ],
        ),
      )
    );
  }
}