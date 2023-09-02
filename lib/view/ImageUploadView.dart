import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadView extends StatefulWidget {
  const ImageUploadView({Key? key}) : super(key: key);

  @override
  _ImageUploadViewState createState() => _ImageUploadViewState();
}

class _ImageUploadViewState extends State<ImageUploadView> {
  final picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("画像アップロード"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image == null ? const Text('No image selected.') : Image.file(image!),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: _getImage,
                  child: Icon(Icons.image),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async => {await uploadFile(file: image!)},
              child: Text("送信"),
            )
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
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
      dio.options.baseUrl = "http://127.0.0.1:8000"; // ベースURLを設定

      if (!file.existsSync()) {
        throw Exception("ファイルが存在しません");
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await dio.post("/image-upload", data: formData);
      print(response);
      return response.data;
    } catch (e) {
      print("エラーが発生しました: $e");
      return null;
    }
  }
}
