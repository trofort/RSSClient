import 'package:flutter/material.dart';
import 'package:rss_client/Router/Router.dart';
import 'package:rss_client/Services/DataBase/DataBaseService.dart';
import 'package:rss_client/Themes/Themes.dart';

class RssClientApp extends StatelessWidget {

  @override
  StatelessElement createElement() {
    DataBaseService.shared.createDB();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Router.all,
      theme: Themes.light,
    );
  }
}