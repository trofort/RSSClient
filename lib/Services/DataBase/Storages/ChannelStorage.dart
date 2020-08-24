import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Services/DataBase/DataBaseService.dart';

class ChannelStorage {

  static Future<void> insert(RSSChannelModel channel) async {
    await DataBaseService.shared.insert(
      TableNames.channels,
      channel.toMap()
    );
  }

  static Future<void> remove(RSSChannelModel channel) async {
    await DataBaseService.shared.remove(
        TableNames.channels,
        'source = ?',
        [channel.source]
    );
  }

  static Future<List<RSSChannelModel>> getAll() async {
    final List<Map<String, dynamic>> maps = await DataBaseService.shared.getAllQuery(TableNames.channels);
    return maps.map((element) => RSSChannelModel.fromDBMap(element)).toList();
  }

}