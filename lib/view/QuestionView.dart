import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final picker = ImagePicker();
  File? image;
  late int answer = 0;
  late String _question = "";
  var questionGenerated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ずんだもん観光案内"),
      ),
      body: Column(
        children: [
          image == null ? const SizedBox(height: 250) : Image.file(image!),
          Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Image.asset('images/zunda.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: (questionGenerated) ? Text(_question) : Text("観光地の画像を見せて欲しいのだ"),
              ),
            )
          ]),

          // if (questionGenerated)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: Text("ダウト"),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: Text("ありがとう"),
          //       ),
          //     ],
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        backgroundColor: Colors.green,
        child: const Icon(Icons.image),
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        uploadFile(file: image!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Object?> uploadFile({
    required File file,
  }) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = "http://127.0.0.1:8000/";

      var apiKey = "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";
      if (!file.existsSync()) {
        throw Exception("ファイルが存在しません");
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        'api': apiKey,
      });

      final response = await dio.post("/question", data: formData);
      print(response.data);
      Map<String, dynamic> data = jsonDecode(response.data);
      setState(() {
        _question = data['question'];
        answer = data['answer'];
        questionGenerated = true;
      });
    } catch (e) {
      print("エラーが発生しました: $e");
      return null;
    }
  }
}
