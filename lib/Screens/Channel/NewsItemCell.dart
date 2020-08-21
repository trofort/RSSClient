import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Router/Router.dart';
import 'package:intl/intl.dart';

class NewsItemCell extends StatelessWidget {

  final RSSNewsItemModel item;

  NewsItemCell({
    Key key,
    this.item
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 150.0,
        maxHeight: double.infinity
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Router.newsWebView, arguments: item),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 24
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _getColumnChildren(),
            )
        ),
      )
    );
  }

  List<Widget> _getColumnChildren() {
    if (item.imageUrl.isEmpty) {
      return [_generateTextPart(), _generateBottomPart()];
    } else {
      return [_generateImagePart(), _generateTextPart(), _generateBottomPart()];
    }
  }

  Widget _generateImagePart() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(bottom: 16.0),
      height: 200.0,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0)
        ),
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: 100.0,
            child: SpinKitRotatingPlain(
              color: Colors.black12,
            ),
          ) ,
          imageUrl: item.imageUrl,
          fit: BoxFit.fitHeight,
          height: 200.0,
        )
      ),
    );
  }

  Widget _generateTextPart() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0)
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.grey[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              item.title,
              style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  item.description,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateBottomPart() {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Uri.tryParse(item.link).host,
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                  decoration: TextDecoration.none
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.only(right: 4.0),
                child: Text(
                  DateFormat('dd.MM.yyyy HH:mm').format(item.pubDate),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      decoration: TextDecoration.none
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}