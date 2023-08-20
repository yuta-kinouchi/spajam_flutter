import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const NextPage());
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ナビゲーションバー"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("push me and get greeting"),
          onPressed: () async {
            //リクエスト先のurl
            Uri url = Uri.parse("http://127.0.0.1:8000/");

            try {
              //リクエストを投げる
              var res = await http.get(url);

              //リクエスト結果をコンソール出力
              debugPrint(res.body);
            } catch (e) {
              //リクエストに失敗した場合は"error"と表示
              debugPrint("error");
            }
          },
        ),
      ),
    );
  }
}
