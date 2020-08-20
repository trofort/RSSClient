import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

class RSSNewsItemModel {
  final String title;
  final String link;
  final DateTime pubDate;
  final String description;
  final String imageUrl;

  RSSNewsItemModel({
    this.title,
    this.link,
    this.pubDate,
    this.description,
    this.imageUrl
  });

  factory RSSNewsItemModel.fromXML(XmlElement element) {
    final String description = element.findElements('description').first.text;
    var imageUrlMatch = RegExp(r'<img[^>]+src="([^">]+)"').firstMatch(description);
    return new RSSNewsItemModel(
      title: element.findElements('title').first.text,
      link: element.findElements('link').first.text,
      pubDate: new DateFormat("E, dd MMM yyyy HH:mm:ss ZZ").parse(element.findElements('pubDate').first.text),
      description: description.replaceAll(RegExp(r'<[^>]*>'), ''),
      imageUrl: imageUrlMatch == null ? '' : imageUrlMatch.group(1)
    );
  }
}