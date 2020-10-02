import 'package:flutter/material.dart';

import 'newsmodel.dart';

class NewsListPage extends StatelessWidget {
  final List<NewsModel> list;

  const NewsListPage({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Text('Empty')
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index].title),
                subtitle: Text(list[index].body),
                leading: Icon(Icons.new_releases),
              );
            },
          );
  }
}
