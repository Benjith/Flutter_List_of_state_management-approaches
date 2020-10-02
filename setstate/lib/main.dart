import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setstate/news_list_page.dart';
import 'package:http/http.dart' as client;
import 'package:setstate/newsmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'setstate state management'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // state is here all state managements are done by here only!
  bool showTxt = true;
  List<NewsModel> _newsList = [];
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: showTxt
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: buttonClick,
                    child: Text(
                      'tap here to fetch data',
                    ),
                  ),
                ],
              ),
            )
          : _newsList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : NewsListPage(
                  list: _newsList,
                ),
    );
  }

  void buttonClick() async {
    setState(() {
      showTxt = false;
    });
    try {
      setState(() {
        showLoader = true;
      });
      var response =
          await client.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        var _jsondata = json.decode(response.body);
        _newsList = List.from(_jsondata.map((x) => NewsModel.fromJson(x)));
        setState(() {
          showLoader = false;
        });
      }
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
