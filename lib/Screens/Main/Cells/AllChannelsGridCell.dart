import 'package:flutter/material.dart';
import 'package:rss_client/Routes/Routes.dart';
import 'package:easy_localization/easy_localization.dart';

class AllChannelsGridCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.allChannels),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Center(
            child: Text(
              'all',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 64.0,
                color: Colors.black
              ),
            ).tr(),
        ),
      ),
    );
  }

}