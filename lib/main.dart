import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:function_tree/function_tree.dart' as ft;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions options = WindowOptions(
    size: Size(500, 500),
    center: true,
    title: 'Calculator',
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    fullScreen: false,
  );

  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp());
}

final ScrollController _scrollController = ScrollController();
String value = '';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void evaluate() {
    try {
      final result = value.interpret();
      setState(() {
        value = result.toString();
      });
    } catch (e) {
      setState(() {
        value = "Error";
      });
    }
  }
  void appendValue(String input) {
    setState(() {
      if (value == "Error") value = '';
      value += input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          leading: Icon(Icons.calculate_rounded),
          title: Text('Calucaluter'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 10.0),
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: false,
                thickness: 4,
                radius: Radius.circular(4),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  reverse: true,
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            Container(height: 2, width: double.infinity, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => appendValue('1'),
                          child: Text('1', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('2'),
                          child: Text('2', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('3'),
                          child: Text('3', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('+'),
                          child: Text('+', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('C'),
                          child: Text('C', style: TextStyle(fontSize: 40)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => appendValue('4'),
                          child: Text('4', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('5'),
                          child: Text('5', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('6'),
                          child: Text('6', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('-'),
                          child: Text('-', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('/'),
                          child: Text('/', style: TextStyle(fontSize: 40)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => appendValue('7'),
                          child: Text('7', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('8'),
                          child: Text('8', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('9'),
                          child: Text('9', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('*'),
                          child: Text('*', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('%'),
                          child: Text('%', style: TextStyle(fontSize: 40)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => appendValue('.'),
                          child: Text('.', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('0'),
                          child: Text('0', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue('('),
                          child: Text('(', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () => appendValue(')'),
                          child: Text(')', style: TextStyle(fontSize: 40)),
                        ),
                        TextButton(
                          onPressed: () {
                            evaluate();
                          },
                          child: Text('=', style: TextStyle(fontSize: 40)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
