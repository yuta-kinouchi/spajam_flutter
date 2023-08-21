import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiConnect extends StatefulWidget {
  const ApiConnect({Key? key}) : super(key: key);

  @override
  _ApiConnectState createState() => _ApiConnectState();
}

class _ApiConnectState extends State<ApiConnect> {
  late String _text = "こんにちは";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_text),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("API経由でテキスト取得"),
              onPressed: () async {
                Uri url = Uri.parse("http://127.0.0.1:8000/");
                try {
                  var res = await http.get(url);
                  debugPrint(res.body);
                  setState(() {
                    _text = res.body;
                  });
                } catch (e) {
                  debugPrint("error");
                }
              },
            ),
            ElevatedButton(
              child: const Text("AIトーク"),
              onPressed: () async {
                Uri url = Uri.parse("http://127.0.0.1:8000/");
                try {
                  var res = await http.get(url);
                  debugPrint(res.body);
                  setState(() {
                    _text = res.body;
                  });
                } catch (e) {
                  debugPrint("error");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
