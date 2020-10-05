import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstate/news_list_widget.dart';
import 'package:providerstate/homepage_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter provider state management'),
      ),
      body: state.showingLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : state.allNewslist.isEmpty
              ? Center(
                  child: InkWell(
                    onTap: () => state.fetchNews(),
                    child: Text('Tap here to fetch news'),
                  ),
                )
              : NewsListWidget(
                  list: state.allNewslist,
                ),
    );
  }
}
