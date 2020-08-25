import 'package:flutter/material.dart';
import 'package:rss_client/Exceptions/AppException.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:http/http.dart' as NetworkService;
import 'package:rss_client/Services/DataBase/Storages/NewsItemStorage.dart';
import 'package:rss_client/Services/HTMLService.dart';
import 'package:rss_client/Views/CustomDialogs/ErrorDialog.dart';

class ChannelController {

  BuildContext context;

  Future<List<RSSNewsItemModel>> getContent(RSSChannelModel channel) async {
    try {
      final List<RSSNewsItemModel> savedNews = await NewsItemStorage.getAll(
          channel);

      final String bodyData = (await NetworkService.get(channel.source)).body;
      final List<RSSNewsItemModel> news = HTMLService.parseChannelNewsItems(
          bodyData);

      final List<RSSNewsItemModel> newsToInsert = news.where((element) =>
          savedNews
              .map((e) => e.link)
              .toList()
              .contains(element.link)
      ).toList();

      await NewsItemStorage.insertAll(newsToInsert);

      savedNews.addAll(newsToInsert);

      return savedNews;
    } on AppException catch(error) {
      await showDialog(
          context: context,
          child: ErrorDialog(message: error.cause)
      );
    }
  }

}