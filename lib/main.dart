import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Homework 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  String _displayedText = '';

  @override
  void dispose() {
    _textFieldController1.dispose();
    _textFieldController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 10), // 調整上方間距
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '請填入出發地', // 出發地字串
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: _textFieldController1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 100), // 增加間距
                  Icon(
                    Icons.arrow_forward,
                    size: 60,
                    color: Colors.brown,
                  ),
                  SizedBox(width: 100), // 增加間距
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '請填入抵達地', // 抵達地字串
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: _textFieldController2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  String text1 = _textFieldController1.text;
                  String text2 = _textFieldController2.text;
                  setState(() {
                    _displayedText = '預計從 $text1 前往 $text2';
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 設置圓角半徑
                  ),
                  backgroundColor: Colors.blueAccent, // 設置按鈕的背景顏色為咖啡色
                ),
                child: SizedBox(
                  width: 150, // 設置按鈕寬度
                  height: 50, // 設置按鈕高度
                  child: Center(
                    child: Text(
                      'Submit',
                      style:
                      TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ), // 設置字體大小
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _displayedText,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
