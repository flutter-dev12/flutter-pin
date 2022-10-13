import 'package:flutter/material.dart';
import 'package:test_flutter_app/pin_screen.dart';
import 'package:test_flutter_app/pin_screen_auth.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PinScreen()),
                  );
                },
                child: const Text('Create a PIN', style: TextStyle(fontSize: 20))
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PinScreenAuth()),
                  );
                },
                child: const Text('Authorize PIN', style: TextStyle(fontSize: 20))
            )
          ],
        ),
      )
    );
  }
}