import 'package:flutter/material.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class NewsWebViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final RSSNewsItemModel newsItem =  ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            iconSize: 24.0,
            onPressed: () => Share.share('check_this_news_@'.tr(args: [newsItem.link])),
          )
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: newsItem.link,
      ),
    );
  }

}