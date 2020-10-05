import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstate/screen.dart';

import 'package:providerstate/homepage_view_model.dart';

void main() {
  runApp(ProviderApp());
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: ChangeNotifierProvider(
        create: (context) => HomePageViewModel(),
        builder: (context, child) => HomePage(),
      ),
      
    );
  }
}
