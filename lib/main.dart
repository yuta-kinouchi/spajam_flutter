import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spajam/view/ApiConnect.dart';
import 'package:spajam/view/ApiDataBaseView.dart';
import 'package:spajam/view/ChatGPTView.dart';
import 'package:spajam/view/DataBaseView.dart';
import 'package:spajam/view/LoginView.dart';
import 'package:spajam/view/VectorSearchView.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  late LoginData login_data = LoginData(email: "",password: "") ;
  // login_data.email =; "qq";
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
                  MaterialPageRoute(builder: (context) => VectorSearchView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('ログイン/ユーザー登録'),
              onPressed: () async {
                final dataFromLoginPage = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView(login_data))
                ) as LoginData;
                setState(() {
                  login_data.email = dataFromLoginPage.email;
                  login_data.password = dataFromLoginPage.password;
                });
              }
              ),
            Text(login_data.email),
            // Text(login_data.password)
          ]),
        ),
      ),
      drawer: const Drawer(child: Center(child: Text("Drawer"))),
    );
  }
}


class LoginData {
  String email;
  String password;

  LoginData({required this.email, required this.password});
}
