import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:rss_client/Screens/ChannelsScreens/Cells/NewsItemCell.dart';
import 'package:rss_client/Services/DataBase/Storages/NewsItemStorage.dart';
import 'package:rss_client/Views/EmptyDataView/EmptyDataView.dart';
import 'package:easy_localization/easy_localization.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('favourite').tr(),
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
                title: 'no_favourite_news'.tr(),
                subtitle: 'you_can_add_them_by_tapping_on_star_icon'.tr(),
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