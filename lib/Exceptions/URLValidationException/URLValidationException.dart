import 'package:rss_client/Exceptions/AppException.dart';
import 'package:easy_localization/easy_localization.dart';

class URLValidationException extends AppException {

  static final URLValidationException emptyUrl = URLValidationException('source_url_is_empty'.tr());
  static final URLValidationException invalidUrl = URLValidationException('please_enter_valid_url'.tr());

  URLValidationException(String cause): super(cause);
}