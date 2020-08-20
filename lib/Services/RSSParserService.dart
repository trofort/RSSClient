import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:http/http.dart' as NetworkService;

import 'HTMLService.dart';

class RSSParserService {

  static Future<RSSChannelModel> parseRSSChannel(String source) async {
    try {
      String url = source;
      if (!url.contains('https://')) {
        url = "https://" + source;
      }

      final String body = (await NetworkService.get(url)).body;
      String rssUrl = HTMLService.getRSSChannelLinkFrom(body);

      if (!rssUrl.contains(source)) {
        rssUrl = url + rssUrl;
      }

      final String channelInfoBody = (await NetworkService.get(rssUrl)).body;
      return HTMLService.parseChannelInfo(channelInfoBody, rssUrl);
    } catch (error) {
      throw error;
    }
  }

}