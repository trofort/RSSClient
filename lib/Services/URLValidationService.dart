import 'package:rss_client/Exceptions/URLValidationException/URLValidationException.dart';

class URLValidationService {
  static void isValidUrl(String url) {
    final String text = url.trim();
    if (text == null || text.isEmpty) {
      throw URLValidationException.emptyUrl;
    }
    final RegExp exp = new RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$");
    if (!exp.hasMatch(text)) {
      throw URLValidationException.invalidUrl;
    }
  }
}