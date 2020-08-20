import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';

class NewsWebViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final RSSNewsItemModel newsItem =  ModalRoute.of(context).settings.arguments;
    return WebviewScaffold(
      url: newsItem.link,
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
    );
  }

}