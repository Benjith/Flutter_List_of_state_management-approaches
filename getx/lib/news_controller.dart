import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx/newsmodel.dart';
import 'package:http/http.dart' as client;

class NewsController extends GetxController {
  List<NewsModel> newsList = [];
  bool showLoader = true;
  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  fetchNews() async {
    setLoader(true);
    try {
      var response =
          await client.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        var _jsondata = json.decode(response.body);
        List<NewsModel> _newsList =
            List.from(_jsondata.map((x) => NewsModel.fromJson(x)));
        if (_newsList.isNotEmpty) newsList.addAll(_newsList);
        update();
      }
    } catch (e) {}
    setLoader(false);
  }

  setLoader(bool value) {
    showLoader = value;
  }
}
