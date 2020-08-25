
import 'package:rss_client/Exceptions/AppException.dart';

class HTMLException extends AppException {

  static final HTMLException cantFindRSSChannel = HTMLException('Can\'t find rss-channel from source.');
  static final HTMLException cantParseRSSChannelInfo = HTMLException('Channel without info.');
  static final HTMLException cantParseNewsItems = HTMLException('Can\'t parse news.');

  HTMLException(String cause): super(cause);
}