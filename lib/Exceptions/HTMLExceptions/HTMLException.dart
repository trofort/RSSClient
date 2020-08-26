
import 'package:rss_client/Exceptions/AppException.dart';
import 'package:easy_localization/easy_localization.dart';

class HTMLException extends AppException {

  static final HTMLException cantFindRSSChannel = HTMLException('cant_find_rss_channel_from_source'.tr());
  static final HTMLException cantParseRSSChannelInfo = HTMLException('channel_without_info'.tr());
  static final HTMLException cantParseNewsItems = HTMLException('cant_parse_news'.tr());

  HTMLException(String cause): super(cause);
}