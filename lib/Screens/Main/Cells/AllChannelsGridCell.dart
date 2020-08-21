import 'package:flutter/material.dart';
import 'package:rss_client/Router/Router.dart';

class AllChannelsGridCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Router.allChannels),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Center(
            child: Text(
              'ALL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 64.0,
                color: Colors.black
              ),
            ),
        ),
      ),
    );
  }

}