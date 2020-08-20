import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:rss_client/Exceptions/HTMLExceptions/HTMLException.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:xml/xml.dart' as xmlParser;

class HTMLService {
  static String getRSSChannelLinkFrom(String body) {
    try {
      final Element rssElement = htmlParser.parse(body)
          .getElementsByTagName('link')
          .firstWhere((element) =>
      element.attributes.containsKey('type') &&
          element.attributes.containsValue('application/rss+xml'));
      return rssElement.attributes['href'];
    } catch (_) {
      throw HTMLException.cantFindRSSChannel;
    }
  }

  static RSSChannelModel parseChannelInfo(String body, String source) {
    try {
      final xmlParser.XmlElement element = xmlParser
          .parse(body)
          .findElements('rss').first
          .findElements('channel').first;
      return RSSChannelModel.fromXML(element, source);
    } catch (_) {
      throw HTMLException.cantParseRSSChannelInfo;
    }
  }

  static List<RSSNewsItemModel> parseChannelNewsItems(String body) {
    try {
      final xmlParser.XmlElement element = xmlParser
          .parse(body)
          .findElements('rss').first
          .findElements('channel').first;
      return element
          .findElements('item')
          .map((e) => RSSNewsItemModel.fromXML(e))
          .toList();
    } catch (_) {
      throw HTMLException.cantParseNewsItems;
    }
  }
}