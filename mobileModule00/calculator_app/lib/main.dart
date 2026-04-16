import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String titleText = 'My first text!';
	String inputText = "0";
  String displayInputText = "0";
	String resultText = "0";
	bool dot = false;
  bool newInput = true;

  void changeInputText(String btn) {
    if (btn == "=") {
      final expr = displayInputText;
      final result = doEvaluation(expr);

      setState(() {
        resultText = result;
      });

      dot = false;
      newInput = true;
      inputText = result; // internal reset only
      return;
    }
    
    String iText = inputText;
    
    // setState(() {
    if (isInt(btn)) {
      if (newInput) {
        iText = "0";
      }
      iText = (iText == "0") ? btn : iText + btn;
    } else if (btn == "AC") {
      iText = "0";
      resultText = "0";
      dot = false;
    } else if (btn == "C") {
      if (iText.substring(iText.length - 1, iText.length) == '.') {
        dot = (dot == true) ? false : true;
      }
      if (iText == "Error") {
        return ;
      }
      iText = (iText.length > 1) ? iText.substring(0, iText.length - 1) : "0";
    } else if (btn == "-") {
      if (iText == "Error") {
        return ;
      }
      if (iText == "0") {
        iText = "-";
      } else {
        iText = iText + btn;
        dot = false;
      }
    } else if (btn == ".") {
      if (newInput) {
        iText = "0";
        dot = false;
      }
      if (isInt(iText.substring(iText.length - 1, iText.length)) && !dot) {
        iText = iText + btn;
        dot = true;
      } else if (!dot) {
        iText = '${iText}0$btn';
        dot = true;
      }
    } else if (btn != "") {
      if (iText == "Error") {
        return ;
      }
      if (isInt(iText.substring(iText.length - 1, iText.length))) {
        dot = false;
        iText = iText + btn;
      } else if (iText.length > 1) {
        dot = false;
        iText = iText.substring(0, iText.length - 1) + btn;
      }
    }

    setState(() {
      inputText = iText;
      displayInputText = iText;
    });

    newInput = false;
    // if (btn == "=") { 
    //   inputText = "0";
    // }
  }

	bool isInt(String str) {
		return ((int.tryParse(str) != null)) ? true : false;
	}

	String doEvaluation(String str) {
    try {
      final exp = GrammarParser().parse(str);
      final value = RealEvaluator().evaluate(exp);

      final d = value.toDouble();
      if (d.isNaN || d.isInfinite) {
        return "Error"; // e.g. invalid math result
      }
      if (value is double && value == value.truncateToDouble()) {
        return value.toInt().toString(); // 5.0 -> "5"
      }
      return value.toString();
    } catch (e) {
      return "Error";
    }
	}

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
									padding: EdgeInsets.all(8.0),
										child: Text(
										displayInputText,
										// inputText,
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
												color: Colors.white70,
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
                          child: Tile(buttons[cellNumber], cellValue, onTap: changeInputText),
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
  const Tile(this.text, this.value, {required this.onTap, super.key});

  final String text;
  final int value;
	final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextButton(
          onPressed: () => onTap(text),
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
          ),),
        ),
      );
  }
}

