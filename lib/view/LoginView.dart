
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class LoginView extends StatelessWidget {
  final LoginData login_data;
  const LoginView(this.login_data);

  // const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ログイン/ユーザー登録"),
        ),
        body: HomePage(login_data));
  }
}

class HomePage extends StatefulWidget {
  final LoginData login_data;
  HomePage(this.login_data);


  @override
  State<HomePage> createState() => _HomePageState(login_data);
}

class _HomePageState extends State<HomePage> {
  final LoginData login_data;
  _HomePageState(this.login_data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(_email),
              // 1行目 メールアドレス入力用テキストフィールド
              Container(
                child: Column(
                  children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      setState(() {
                       login_data.email = value;
                      });
                   },
                  ),
                 // 2行目 パスワード入力用テキストフィールド
                 TextFormField(
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      login_data.password = value;
                    });
                  },
                ),
                  ],
                )
              ),
             Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   ElevatedButton(
                     child: const Text('ユーザ登録'),
                     onPressed: () async {
                       try {
                         final User? user = (await FirebaseAuth.instance
                             .createUserWithEmailAndPassword(
                             email: login_data.email, password: login_data.password))
                             .user;
                         if (user != null)
                           print("ユーザ登録しました ${user.email} , ${user.uid}");
                         Navigator.pop(context, login_data);
                       } catch (e) {
                         print(e);
                       }
                     },
                   ),
                   // 4行目 ログインボタン
                   ElevatedButton(
                     child: const Text('ログイン'),
                     onPressed: () async {
                       try {
                         // メール/パスワードでログイン
                         final User? user = (await FirebaseAuth.instance
                             .signInWithEmailAndPassword(
                             email: login_data.email, password: login_data.password))
                             .user;
                         if (user != null)
                           print("ログインしました　${user.email} , ${user.uid}");
                         Navigator.pop(context, login_data);
                       } catch (e) {
                         print(e);
                       }
                     },
                   ),
                 ],
               )
             ),
              Container(
                child: Column(
                  children: [
                    ElevatedButton(
                        child: const Text('パスワードリセット'),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: login_data.email);
                            print("パスワードリセット用のメールを送信しました");
                          } catch (e) {
                            print(e);
                          }
                        }),
                    ElevatedButton(
                        child: const Text('ログアウト'),
                        onPressed: () async {
                          setState(() {
                            login_data.email = "";
                            login_data.password = "";
                          });
                          Navigator.pop(context, login_data);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}