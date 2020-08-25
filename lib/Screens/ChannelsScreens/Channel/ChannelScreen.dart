import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/ChannelsScreens/Controller/ChannelController.dart';
import '../Cells/NewsItemCell.dart';


class ChannelScreen extends StatelessWidget {

  ChannelController _controller = ChannelController();

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    RSSChannelModel channel = ModalRoute.of(context).settings.arguments;
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(channel.title),
              background: Hero(
                tag: channel.source,
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    if (url.isNotEmpty) {
                      return SpinKitRotatingPlain(
                        color: Colors.black12,
                      );
                    } else {
                      return Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            Uri.parse(channel.source).host,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 32.0,
                              decoration: TextDecoration.none,
                              fontFamily: '.SF UI Text'
                            ),
                          ),
                      );
                    }
                  },
                  imageUrl: channel.imageUrl,
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                  width: double.infinity,
                )
              ),
            ),
          ),
          FutureBuilder(
            future: _controller.getContent(channel),
            builder: (BuildContext context, AsyncSnapshot<List<RSSNewsItemModel>> snapshot) {
              if (snapshot.hasData) {
                List<RSSNewsItemModel> news = snapshot.data;
                news.sort((a, b) => b.pubDate.compareTo(a.pubDate));
                return SliverList(
                  delegate: SliverChildListDelegate(
                      news.map((item) => NewsItemCell(item: item)).toList()
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: SpinKitWave(
                      color: Colors.black,
                    ),
                  )
                );
              }
            },
          )
        ],
      ),
    );
  }

}