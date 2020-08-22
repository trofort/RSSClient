import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Router/Router.dart';

class ChannelGridCell extends StatelessWidget {

  final RSSChannelModel channel;

  ChannelGridCell({
    Key key,
    this.channel
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => Navigator.pushNamed(context, Router.channel, arguments: channel),
      child: new Card(
        clipBehavior: Clip.antiAlias,
        child: new Stack(
          children: <Widget>[
            new Align(
              child: new Hero(
                tag: channel.source,
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    if (url.isNotEmpty) {
                      return SpinKitRotatingPlain(
                        color: Colors.black12,
                      );
                    } else {
                      return AutoSizeText(
                        Uri.parse(channel.source).host,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 32.0,
                          decoration: TextDecoration.none,
                          fontFamily: '.SF UI Text'
                        ),
                      );
                    }
                  },
                  imageUrl: channel.imageUrl,
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                  width: double.infinity,
                )
              )
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                  padding: EdgeInsets.all(8.0),
                  height: 75.0,
                  width: double.infinity,
                  color: Colors.black54,
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          channel.title,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15.0
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                            channel.description,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 12.0
                            ),
                            overflow: TextOverflow.ellipsis
                        ),
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}