import 'package:http/http.dart' as http;

class DataBaseViewController {
  void _fetchData() async {
    Uri url = Uri.parse("http://127.0.0.1:8000/");
    var res = http.get(url);
  }
}
