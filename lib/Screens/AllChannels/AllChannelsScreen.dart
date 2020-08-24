import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as NetworkService;
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/Channel/NewsItemCell.dart';
import 'package:rss_client/Services/DataBase/Storages/ChannelStorage.dart';
import 'package:rss_client/Services/DataBase/Storages/NewsItemStorage.dart';
import 'package:rss_client/Services/HTMLService.dart';

class AllChannelsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All')
      ),
      body: FutureBuilder(
        future: ChannelStorage.getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<RSSChannelModel>> snapshot) {
          if (snapshot.hasData) {
            final allCannels = snapshot.data;
            return FutureBuilder(
              future: Future.wait(allCannels.map((e) => _getContent(e))),
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
    );
  }

  Widget _waveLoader() {
    return Center(
      child: SpinKitWave(
        color: Colors.black,
      ),
    );
  }

  Future<List<RSSNewsItemModel>> _getContent(RSSChannelModel channel) async {
    final String bodyData = (await NetworkService.get(channel.source)).body;
    final List<RSSNewsItemModel> news = HTMLService.parseChannelNewsItems(bodyData);
    await NewsItemStorage.insertAll(news);
    return await NewsItemStorage.getAll(channel);
  }

}