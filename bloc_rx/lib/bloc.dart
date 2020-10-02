import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as client;

import 'newsmodel.dart';

class MyAppBloc {
  final StreamController<List<NewsModel>> _newsStreamContoller =
      StreamController<List<NewsModel>>.broadcast();

  Stream<List<NewsModel>> get newsStream => _newsStreamContoller.stream;

  void fetchNews() async {
    try {
      var response =
          await client.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        var _jsondata = json.decode(response.body);
        List<NewsModel> _newsList =
            List.from(_jsondata.map((x) => NewsModel.fromJson(x)));
        _newsStreamContoller.add(_newsList);
      }
    } catch (e) {
      _newsStreamContoller.addError(e.toString());
    }
  }

  void dispose() {
    _newsStreamContoller.close();
  }
}
