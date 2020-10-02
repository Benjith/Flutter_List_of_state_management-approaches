import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as client;
import 'newsmodel.dart';

class HomePageViewModel extends ChangeNotifier {
  bool showingLoader = false;
  List<NewsModel> _allNewsList = [];
  List<NewsModel> get allNewslist => _allNewsList;

  void fetchNews() async {
    showLoader(true);
    var response =
        await client.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      var _jsondata = json.decode(response.body);
      _allNewsList = List.from(_jsondata.map((x) => NewsModel.fromJson(x)));
      showLoader(false);
    }
  }

  void showLoader(bool value) {
    showingLoader = value;
    notifyListeners();
  }
}
