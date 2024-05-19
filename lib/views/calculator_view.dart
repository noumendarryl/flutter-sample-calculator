import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widgets/calculator_button.dart';



class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String content = "0";

  void display(String char) {
    setState(() {
      if (content == "0") {
        content = char;
      } else {
        content += char;
      }
    });
  }

  void calculate() {
    content =
        content.replaceAll(RegExp(r'×'), '*').replaceAll(RegExp(r'÷'), '/');
    setState(() {
      Parser p = Parser();
      ContextModel cm = ContextModel();
      Expression expr = p.parse(content);
      content = expr.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  void negate() {
    setState(() {
      if (content != "0") {
        if (content.startsWith("-") ||
            content.contains("+") ||
            content.contains("-") ||
            content.contains("×") ||
            content.contains("÷")) {
          content = "-($content)";
        } else {
          content = "-$content";
        }
      }
    });
  }

  void reverse() {
    setState(() {
      if (content != "0") {
        if (content.contains("+") ||
            content.contains("-") ||
            content.contains("×") ||
            content.contains("÷")) {
          content = "1 ÷ ($content)";
        } else {
          content = "1 ÷ $content";
        }
      }
    });
  }

  void square() {
    setState(() {
      if (content != "0") {
        if (content.contains("+") ||
            content.contains("-") ||
            content.contains("×") ||
            content.contains("÷")) {
          content = "($content)^2";
        } else {
          content = "$content^2";
        }
      }
    });
  }

  void root() {
    setState(() {
      if (content != "0") {
        content = "sqrt($content)";
      }
    });
  }

  void clear() {
    setState(() {
      content = "0";
    });
  }

  void clearEntry() {
    setState(() {
      if (content != "0") {
        // Check if the content starts with a negation operator
        if (content.startsWith("-")) {
          // If it does, remove the negation operator
          content = content.substring(1);
        } else {
          // Otherwise, check if the content has more than one character
          if (content.length > 1) {
            // If it does, remove the last character
            content = content.substring(0, content.length - 1);
          } else {
            // If it has only one character, set it to "0"
            content = "0";
          }
        }
      }
    });
  }

  void delete() {
    setState(() {
      if (content.isNotEmpty && content != "0") {
        content = content.substring(0, content.length - 1);
        if (content.isEmpty) {
          content = "0";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.menu),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Text(
                      "Standard",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Icon(Icons.backup_table_rounded),
                    Padding(padding: EdgeInsets.all(8.0)),
                  ],
                ),
                Icon(Icons.history),
              ],
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text("MC",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text("MR",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text("M+",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text("M-",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text("MS",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text("Mv",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "%",
                            onPressed: () {
                              display("%");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "CE",
                            onPressed: () {
                              clearEntry();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "C",
                            onPressed: () {
                              clear();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "DEL",
                            onPressed: () {
                              delete();
                            })),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "1/x",
                            onPressed: () {
                              reverse();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "x²",
                            onPressed: () {
                              square();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "²√x",
                            onPressed: () {
                              root();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "÷",
                            onPressed: () {
                              display("÷");
                            })),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "7",
                            onPressed: () {
                              display("7");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "8",
                            onPressed: () {
                              display("8");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "9",
                            onPressed: () {
                              display("9");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "×",
                            onPressed: () {
                              display("×");
                            })),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "4",
                            onPressed: () {
                              display("4");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "5",
                            onPressed: () {
                              display("5");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "6",
                            onPressed: () {
                              display("6");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "-",
                            onPressed: () {
                              display("-");
                            })),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "1",
                            onPressed: () {
                              display("1");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "2",
                            onPressed: () {
                              display("2");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "3",
                            onPressed: () {
                              display("3");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "+",
                            onPressed: () {
                              display("+");
                            })),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            label: "+/-",
                            onPressed: () {
                              negate();
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "0",
                            onPressed: () {
                              display("0");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: ",",
                            onPressed: () {
                              display(".");
                            })),
                    Expanded(
                        child: CalculatorButton(
                            label: "=",
                            onPressed: () {
                              calculate();
                            })),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
