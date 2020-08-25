import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

class RSSNewsItemModel {

  static final String entityModel = 'title Text, link TEXT PRIMARY KEY, description TEXT, imageUrl TEXT, pubDate TEXT, source TEXT, isFavourite INTEGER';

  final String title;
  final String link;
  final DateTime pubDate;
  final String description;
  final String imageUrl;
  final String source;
  bool isFavourite;

  RSSNewsItemModel({
    this.title,
    this.link,
    this.pubDate,
    this.description,
    this.imageUrl,
    this.source,
    this.isFavourite
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'imageUrl': imageUrl,
      'pubDate': DateFormat("dd.MM.yyyy HH:mm").format(pubDate),
      'source': source,
      'isFavourite': isFavourite ? 1 : 0
    };
  }

  factory RSSNewsItemModel.fromDBMap(Map<String, dynamic> dbMap) {
    return RSSNewsItemModel(
      title: dbMap['title'],
      link: dbMap['link'],
      pubDate: DateFormat("dd.MM.yyyy HH:mm").parse(dbMap['pubDate']),
      description: dbMap['description'],
      imageUrl: dbMap['imageUrl'],
      source: dbMap['source'],
      isFavourite: dbMap['isFavourite'] == 1
    );
  }

  factory RSSNewsItemModel.fromXML(XmlElement element, String source) {
    final String description = element.findElements('description').first.text;
    var imageUrlMatch = RegExp(r'<img[^>]+src="([^">]+)"').firstMatch(description);
    return new RSSNewsItemModel(
      title: element.findElements('title').first.text,
      link: element.findElements('link').first.text,
      pubDate: new DateFormat("E, dd MMM yyyy HH:mm:ss ZZ").parse(element.findElements('pubDate').first.text),
      description: description.replaceAll(RegExp(r'<[^>]*>'), ''),
      imageUrl: imageUrlMatch == null ? '' : imageUrlMatch.group(1),
      source: source,
      isFavourite: false
    );
  }
}