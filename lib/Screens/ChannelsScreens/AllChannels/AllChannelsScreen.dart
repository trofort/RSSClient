import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/ChannelsScreens/Cells/NewsItemCell.dart';
import 'package:rss_client/Screens/ChannelsScreens/Controller/ChannelController.dart';
import 'package:rss_client/Services/DataBase/Storages/ChannelStorage.dart';
import 'package:easy_localization/easy_localization.dart';

class AllChannelsScreen extends StatefulWidget {

  createState() => _AllChannelsScreenState();

}

class _AllChannelsScreenState extends State<AllChannelsScreen> {

  final ChannelController _controller = ChannelController();

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('all').tr()
      ),
      body: RefreshIndicator(
        onRefresh: () async { setState(() {}); },
        child: FutureBuilder(
          future: ChannelStorage.getAll(),
          builder: (BuildContext context, AsyncSnapshot<List<RSSChannelModel>> snapshot) {
            if (snapshot.hasData) {
              final allChannels = snapshot.data;
              return FutureBuilder(
                future: Future.wait(allChannels.map((e) => _controller.getContent(e))),
                builder: (BuildContext context, AsyncSnapshot<List<List<RSSNewsItemModel>>> snapshot) {
                  if (snapshot.hasData) {
                    final allNews = snapshot.data
                        .expand((element) => element)
                        .toList();
                    allNews.sort((a, b) => b.pubDate.compareTo(a.pubDate));
                    return ListView(
                      children: allNews.map((e) => NewsItemCell(item: e,)).toList(),
                    );
                  } else {
                    return _waveLoader();
                  }
                },
              );
            } else {
              return _waveLoader();
            }
          },
        ),
      )
    );
  }

  Widget _waveLoader() {
    return Center(
      child: SpinKitWave(
        color: Colors.black,
      ),
    );
  }

}