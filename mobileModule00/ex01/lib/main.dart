import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String titleText = 'My first text!';

  void changeTitleText() {
    setState(() {
      titleText = (titleText == 'My first text!') ? 'Text changed!' : 'My first text!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 220,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            color: Colors.green.shade200,
          ),
          child: Center(
            child: Text(
              titleText,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        TextButton(
          onPressed: changeTitleText,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(16.0)
          ),
          child: const Text('Click Me'),
        ),
      ],
    );
  }
}



