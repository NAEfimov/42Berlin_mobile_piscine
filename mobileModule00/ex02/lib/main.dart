import 'package:flutter/material.dart';

const buttons = ["7", "8", "9", "C", "AC", "4", "5", "6", "+", "-", "1", "2", "3", "*", "/", "0", ".", "00", "=", ""];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'Calculator',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SizedBox.expand(
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
	String inputText = "0";
	String resultText = "0";
	bool dot = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: ColoredBox(
            color: Colors.blue,
            child: Column(
              children: [
								Container(
									width: double.infinity,
									// height: 60,
									padding: EdgeInsets.all(8.0),
									// decoration: BoxDecoration(
									// 	border: Border.all(color: Colors.blue.shade800,),
									// 	// color: Colors.green.shade200,
									// ),
									child: Text(
										inputText,
										textAlign: TextAlign.right,
										style: TextStyle(
											color: Colors.white,
											fontSize: 30.0,
										),
									),
								),
								Container(
									width: double.infinity,
									// height: 60,
									padding: EdgeInsets.all(8.0),
									// decoration: BoxDecoration(
									// 	border: Border.all(color: Colors.blue.shade800),
									// 	// color: Colors.green.shade200,
									// ),
										child: Text(
											resultText,
											textAlign: TextAlign.right,
											style: TextStyle(
												color: Colors.white,
												fontSize: 30.0,
											),
										),
								),
							],	
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ColoredBox(
            color: Colors.blue.shade800,
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Column(
                children: List.generate(4, (row) {
                  return Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(5, (col) {
                        final cellNumber = row * 5 + col;
                        final cellValue = (int.tryParse(buttons[cellNumber]) != null) ? int.parse(buttons[cellNumber]) : 0;
                        // print('$cellNumber: $cellValue');
                        return Expanded(
                          child: Tile(buttons[cellNumber], cellValue),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  const Tile(this.text, this.value, {super.key});

  final String text;
  final int value;

  void printText(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextButton(
          onPressed: () => printText('button pressed: $text'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3), // 3 px rounded corners
            ),
          ),
          child: Text(text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      );
  }
}

