import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/news_controller.dart';
import 'package:getx/news_list_page.dart';
import 'package:getx/newsmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Getx State management'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GetBuilder<NewsController>(
            init: NewsController(),
            builder: (controller) => controller.newsList.isEmpty
                ? Center(
                    child: RaisedButton(
                        onPressed: () {}, child: Text('Fetch news')))
                : controller.showLoader
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : NewsListPage(
                        list: controller.newsList,
                      )));
  }
}
