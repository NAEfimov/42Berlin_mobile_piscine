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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: const EdgeInsets.all(2.0),
      child: Column(
        spacing: 5.0,
        mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Centers children horizontally
        children: [
          Container(
            width: 200,
            height: 60,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              color: Colors.green.shade200,
            ),
            child: Center(
              child: Text(
                'My first text!',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ), 
          ),
          TextButton(
            onPressed: () {
              print('Button pressed');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Text color
              backgroundColor: Colors.blue, // Button background color
              padding: EdgeInsets.all(16.0), // Padding inside the button
            ),
            child: Text('Click Me'),
          ),
        ],
      ),
    );
  }
}
