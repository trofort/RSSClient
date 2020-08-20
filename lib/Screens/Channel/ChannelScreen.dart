import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/Channel/NewsItemCell.dart';
import 'package:rss_client/Services/HTMLService.dart';
import 'NewsItemCell.dart';
import 'package:http/http.dart' as NetworkService;

class ChannelScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                  placeholder: (context, url) => SpinKitRotatingPlain(
                    color: Colors.black12,
                  ),
                  imageUrl: channel.imageUrl,
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                  width: double.infinity,
                )
              ),
            ),
          ),
          FutureBuilder(
            future: NetworkService.get(channel.source),
            builder: (BuildContext context, AsyncSnapshot<NetworkService.Response> snapshot) {
              if (snapshot.hasData) {
                List<RSSNewsItemModel> news = HTMLService.parseChannelNewsItems(snapshot.data.body);
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