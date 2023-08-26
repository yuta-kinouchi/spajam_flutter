import 'package:flutter/material.dart';
import 'package:spajam/view/ApiConnect.dart';
import 'package:spajam/view/ApiDataBaseView.dart';
import 'package:spajam/view/ChatGPTView.dart';
import 'package:spajam/view/DataBaseView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            ElevatedButton(
              child: const Text('AIトークAPI接続'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApiConnect()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('データベースCRUD実装ページ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataBaseView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('ログイン、APIデータベース連携'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiDataBaseView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('chatGPT'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatGPTView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('ベクトルデータベース'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatGPTView()),
                );
              },
            ),
          ]),
        ),
      ),
      drawer: const Drawer(child: Center(child: Text("Drawer"))),
    );
  }
}
