import 'package:flutter/material.dart';

class DataBaseView extends StatefulWidget {
  const DataBaseView({Key? key}) : super(key: key);

  @override
  _DataBaseViewState createState() => _DataBaseViewState();
}

class _DataBaseViewState extends State<DataBaseView> {
  // 定数リストにconstを追加
  final List<String> user = const [
    "User 1",
    "User 2",
    "User 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database View"),
      ),
      body: ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(user[index]),
          );
        },
      ),
    );
  }
}
