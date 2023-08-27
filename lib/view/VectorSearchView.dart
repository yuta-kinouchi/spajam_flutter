import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VectorSearchView extends StatefulWidget {
  const VectorSearchView({Key? key}) : super(key: key);

  @override
  _VectorSearchViewState createState() => _VectorSearchViewState();
}

class _VectorSearchViewState extends State<VectorSearchView> {
  String _question = "";
  late String _answer = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ベクトル検索"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.length < 5) {
                  return 'Please enter some Text'; //無効
                } else {
                  print('OK');
                  _question = value;
                  return null; //有効
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _accessGPT(_question);
                }
              },
              child: Text('送信'),
            ),
            Text(_answer),
          ],
        ),
      ),
    );
  }

  Future<void> _accessGPT(String question) async {
    print(question);
    Uri url = Uri.parse("http://127.0.0.1:8000/vector-search/?question=$question");
    try {
      var res = await http.get(url);
      debugPrint(res.body);
      setState(() {
        _answer = utf8.decode(res.body.runes.toList());
      });
    } catch (e) {
      debugPrint("error");
    }
  }
}
