import 'package:xml/xml.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';

class RSSChannelModel {

  static final String entityModel = 'title Text, source TEXT PRIMARY KEY, description TEXT, imageUrl TEXT';

  final String title;
  final String source;
  final String description;
  final String imageUrl;

  RSSChannelModel({
    this.title,
    this.source,
    this.description,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'source': source,
      'description': description,
      'imageUrl': imageUrl
    };
  }

  factory RSSChannelModel.fromXML(XmlElement element, String source) {
    return new RSSChannelModel(
      title: element.findElements('title').first.text,
      source: source,
      description: element.findElements('description').first.text,
      imageUrl: element.findElements('image').first.findElements('url').first.text
    );
  }
}