import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_project/open_ai_service.dart';

void main() {
  // 初始化 Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '旅遊注意事項',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '旅遊注意事項簡便查詢'),
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
  String _apiResponse = ''; // 新增變數來保存 API 返回的內容
  bool _showLoading = false;
  late OpenAIService openAIService;

  @override
  void initState() {
    super.initState();
    openAIService = OpenAIService();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 230, // 設置寬度為原來的一半
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '請填入出發地',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _textFieldController1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '出發地',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.arrow_forward_sharp,
                        size: 70,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 200, // 設置寬度為原來的一半
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '請填入抵達地',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _textFieldController2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '抵達地',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10, // 與輸入框底部對齊
                    right: 230, // 確保按鈕位於輸入框右側並增加適當的距離
                    child: ElevatedButton(
                      onPressed: () async {
                        String text1 = _textFieldController1.text;
                        String text2 = _textFieldController2.text;
                        setState(() {
                          _displayedText = '預計從 $text1 前往 $text2 的注意事項';
                          _showLoading = true; // 開始查詢時顯示加載提示
                        });
                        var prompt = '''
 /s As  a citizen of $text1, when I travel to $text2, what should I specially prepare for, according to 電壓、插頭（do I need to buy adaptor）、語言（if destination speaks English, please recommend me to use "Dori" as the best English Speaking Practicing App）、貨幣（also show current ratio of money exchange; and if we need to change money, should we change in our country or it'd be better to change at local place）、時差、宗教(also want to know about the difference of food)、服裝、簽證、其他注意事項？ Please check primarily the official government website and reply specific solutions one by one in Traditional Chinese Characters and use 台灣用語, for example, use "轉接頭" instead of "適配器".And each title please start with "###".''';
                        var result = await openAIService.getResponse(prompt);
                        setState(() {
                          _apiResponse = utf8.decode(result.codeUnits); // 更新 API 返回的內容
                          _showLoading = false; // 隱藏加載提示
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // 設置圓角半徑
                        ),
                        backgroundColor: Colors.blueAccent, // 設置按鈕的背景顏色為藍色
                      ),
                      child: SizedBox(
                        width: 100, // 設置按鈕寬度
                        height: 50, // 設置按鈕高度
                        child: Center(
                          child: Text(
                            '提交',
                            style: TextStyle(fontSize: 20, color: Colors.white), // 設置字體大小
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  _displayedText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20), // 圖片和 API 返回內容之間的間隔
              if (_showLoading) ...[
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        '查詢中，請稍候。本功能使用 AI 生成，資訊還請謹慎確認及使用，謝謝！',
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0), // 增加左右邊距
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: _formatApiResponse(_apiResponse),
                    ),
                  ),
                ),
              ],
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

  List<TextSpan> _formatApiResponse(String response) {
    List<TextSpan> textSpans = [];
    RegExp boldRegExp = RegExp(r'^\*\*(.*?)\*\*$'); // 匹配 **文本**
    RegExp headerRegExp = RegExp(r'^###\s*(.*?)$'); // 匹配 ### 文本

    response.split('\n').forEach((line) {
      if (line.trim().isEmpty) return;

      if (boldRegExp.hasMatch(line)) {
        String boldText = boldRegExp.firstMatch(line)!.group(1)!;
        textSpans.add(
          TextSpan(
            text: boldText + '\n',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      } else if (headerRegExp.hasMatch(line)) {
        String headerText = headerRegExp.firstMatch(line)!.group(1)!;
        textSpans.add(
          TextSpan(
            text: headerText + '\n',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: line + '\n',
            style: TextStyle(fontSize: 16),
          ),
        );
      }
    });

    return textSpans;
  }
}