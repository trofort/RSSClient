import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/ChannelsScreens/Cells/NewsItemCell.dart';
import 'package:rss_client/Services/DataBase/Storages/NewsItemStorage.dart';
import 'package:rss_client/Views/EmptyDataView/EmptyDataView.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
      ),
      body: FutureBuilder(
        future: NewsItemStorage.getAllFavourite(),
        builder: (BuildContext context, AsyncSnapshot<List<RSSNewsItemModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView(
                children: snapshot.data.map((e) => NewsItemCell(item: e)).toList(),
              );
            } else {
              return EmptyDataView(
                title: 'No Favourite News',
                subtitle: 'You can add them by tapping on star',
              );
            }
          } else {
            return SpinKitWave(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}