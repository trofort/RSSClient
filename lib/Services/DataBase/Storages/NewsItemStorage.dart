import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Services/DataBase/DataBaseService.dart';

class NewsItemStorage {

  static Future<void> insert(RSSNewsItemModel newsItem) async {
    await DataBaseService.shared.insert(
        TableNames.newsItems,
        newsItem.toMap()
    );
  }

  static Future<void> insertAll(List<RSSNewsItemModel> news) async {
    for (RSSNewsItemModel newsItem in news) {
      await insert(newsItem);
    }
  }

  static Future<List<RSSNewsItemModel>> getAll(RSSChannelModel channel) async {
    final List<Map<String, dynamic>> maps = await DataBaseService.shared.getAllQuery(
        TableNames.newsItems,
      where: 'source = ?',
      whereArgs: [channel.title]
    );
    return maps.map((element) => RSSNewsItemModel.fromDBMap(element)).toList();
  }

}