import 'package:flutter/material.dart';
import 'package:rss_client/Exceptions/HTMLExceptions/HTMLException.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Screens/Main/Cells/AllChannelsGridCell.dart';
import 'package:rss_client/Screens/Main/Cells/ChannelGridCell.dart';
import 'package:rss_client/Services/DataBaseService.dart';
import 'package:rss_client/Services/RSSParserService.dart';
import 'package:rss_client/Views/CustomDialogs/AddSourceDialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Views/CustomDialogs/ErrorDialog.dart';
import 'package:rss_client/Views/EmptyDataView/EmptyDataView.dart';

class MainScreen extends StatefulWidget {
  createState() => _MainState();
}

class _MainState extends State<MainScreen> {

  bool _haveLoadingItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('RSS Client'),
        actions: <Widget>[
          FlatButton(
            onPressed: _showEnterUrlPopUp,
            child: new Icon(
              Icons.add,
              size: 24.0,
            ))
        ],
      ),
      body: 
      FutureBuilder(
        future: DataBaseService.shared.getAllChannels(),
        builder: (BuildContext context, AsyncSnapshot<List<RSSChannelModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return GridView.count(
                crossAxisCount: 2,
                children: _generateGridChildren(snapshot.data),
              );
            } else {
              return EmptyDataView(
                title: 'No channels',
                subtitle: 'Please, add channels',
              );
            }
          } else {
            return SpinKitWave(
              color: Colors.black,
            );
          }
        },
      )
    );
  }

  List<Widget> _generateGridChildren(List<RSSChannelModel> channels) {
    List<Widget> gridChildren = List<Widget>();

    final channelCells = channels.map((e) => ChannelGridCell(channel: e)).toList();

    if (channelCells.length > 1) {
      gridChildren.add(AllChannelsGridCell());
    }

    gridChildren.addAll(channelCells);

    if (_haveLoadingItem) {
      gridChildren.add(SpinKitRotatingPlain(color: Colors.black12));
    }

    return gridChildren;
  }

  void _showEnterUrlPopUp() async {
    await showDialog(
      context: context,
      child: AddSourceDialog(
        addOnTapped: (sourceUrl) async {
          setState(() {
            _haveLoadingItem = true;
          });
          try {
            final channel = await RSSParserService.parseRSSChannel(sourceUrl);
            await DataBaseService.shared.insertChannel(channel);
          } on HTMLException catch (error) {
            await showDialog(
              context: context,
              child: ErrorDialog(message: error.cause)
            );
          } catch (_) {
            await showDialog(
              context: context,
              child: ErrorDialog(message: 'Network problem')
            );
          } finally {
            setState(() {
              _haveLoadingItem = false;
            });
          }
        },
      )
    );
  }
}