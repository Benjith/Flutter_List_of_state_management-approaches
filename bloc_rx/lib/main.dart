import 'package:bloc_rx/news_list_page.dart';
import 'package:bloc_rx/newsmodel.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

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
      home: MyHomePage(title: 'Flutter bloc_rx state management'),
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
  // state is here but handling from outside; from a bloc pattern

  MyAppBloc _bloc = MyAppBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<NewsModel>>(
          initialData: [],
          stream: _bloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return InkWell(
                onTap: () => _bloc.fetchNews(),
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }
            return streamHandler(snapshot);
          }),
    );
  }

  Widget streamHandler(AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        return NewsListPage(
          list: snapshot.data,
        );
        break;
      case ConnectionState.waiting:
        _bloc.fetchNews();
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      default:
        return Text('done with stream');
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
