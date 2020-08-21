import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_client/Screens/AllChannels/AllChannelsScreen.dart';
import 'package:rss_client/Screens/Channel/ChannelScreen.dart';
import 'package:rss_client/Screens/Main/MainScreen.dart';
import 'package:rss_client/Screens/NewsWebViewScreen/NewsWebViewScreen.dart';

class Router {

  static final String main = '/';
  static final String channel = '/channel';
  static final String newsWebView = '/newsWebView';
  static final String allChannels = '/allChannels';

  static final Map<String, WidgetBuilder> all = {
    main: (BuildContext context) => MainScreen(),
    channel: (BuildContext context) => ChannelScreen(),
    newsWebView: (BuildContext context) => NewsWebViewScreen(),
    allChannels: (BuildContext context) => AllChannelsScreen()
  };
}