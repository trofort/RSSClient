
class HTMLException implements Exception {

  static final HTMLException cantFindRSSChannel = HTMLException('Can\'t find rss-channel from source.');
  static final HTMLException cantParseRSSChannelInfo = HTMLException('Channel without info.');
  static final HTMLException cantParseNewsItems = HTMLException('Can\'t parse news.');

  String cause;
  HTMLException(this.cause);
}