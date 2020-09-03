import 'package:flutter/material.dart';
import 'package:rss_client/Screens/ChannelsScreens/AllChannels/AllChannelsScreen.dart';
import 'package:rss_client/Screens/ChannelsScreens/Channel/ChannelScreen.dart';
import 'package:rss_client/Screens/Favourite/FavouriteScreen.dart';
import 'package:rss_client/Screens/Main/MainScreen.dart';
import 'package:rss_client/Screens/NewsWebViewScreen/NewsWebViewScreen.dart';

class Routes {

  static final String main = '/';
  static final String channel = '/channel';
  static final String newsWebView = '/newsWebView';
  static final String allChannels = '/allChannels';
  static final String favourite = '/favourite';

  static final Map<String, WidgetBuilder> all = {
    main: (_) => MainScreen(),
    channel: (_) => ChannelScreen(),
    newsWebView: (_) => NewsWebViewScreen(),
    allChannels: (_) => AllChannelsScreen(),
    favourite: (_) => FavouriteScreen()
  };
}