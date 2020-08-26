import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppLocalization extends StatelessWidget{

  final Widget app;

  AppLocalization(this.app, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/localizations',
        fallbackLocale: Locale('en', 'US'),
        child: app
    );
  }

}