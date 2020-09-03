import 'package:flutter/material.dart';
import 'package:rss_client/Routes/Routes.dart';
import 'package:rss_client/Services/DataBase/DataBaseService.dart';
import 'package:rss_client/Themes/Themes.dart';
import 'package:easy_localization/easy_localization.dart';

class RssClientApp extends StatelessWidget {

  @override
  StatelessElement createElement() {
    DataBaseService.shared.createDB();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: Routes.all,
      theme: Themes.light,
    );
  }
}