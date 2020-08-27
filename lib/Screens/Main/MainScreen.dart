import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Router/Router.dart';
import 'package:rss_client/Screens/Main/Cells/AllChannelsGridCell.dart';
import 'package:rss_client/Screens/Main/Cells/ChannelGridCell.dart';
import 'package:rss_client/Screens/Main/MainScreenController.dart';
import 'package:rss_client/Services/DataBase/Storages/ChannelStorage.dart';
import 'package:rss_client/Views/CustomDialogs/AddSourceDialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_client/Views/EmptyDataView/EmptyDataView.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget {

  createState() => _MainState();
}

class _MainState extends State<MainScreen> {

  final MainScreenController _controller = MainScreenController();

  bool _haveLoadingItem = false;
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    return FutureBuilder(
      future: ChannelStorage.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<RSSChannelModel>> snapshot) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            android: (_) => MaterialAppBarData(
              titleSpacing: 0.0,
              centerTitle: true
            ),
           automaticallyImplyLeading: false,
           title: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: _getAppBarTitleView(snapshot),
           ),
           trailingActions: <Widget>[
             Container(
               width: 35.0,
               child: PlatformIconButton(
                 onPressed: () => Navigator.pushNamed(context, Router.favourite),
                 icon: Icon(
                   Icons.star_border,
                 ),
               )
             ),
             Container(
               width: 35.0,
               child: PlatformIconButton(
                 onPressed: _showEnterUrlPopUp,
                 icon: Icon(
                   Icons.add,
                 )
               ),
             )
           ],
          ),
          body: _generateScaffoldBody(snapshot),
        );
      },
    );
  }

  List<Widget> _generateGridChildren(List<RSSChannelModel> channels) {
    List<Widget> gridChildren = List<Widget>();

    final channelCells = channels.map((e) {
      List<Widget> stackChildren = List<Widget>()
        ..add(ChannelGridCell(
          channel: e,
          isEdit: _isEdit,
        ));

      if (_isEdit) {
        stackChildren.add(
          Align(
            alignment: Alignment.topRight,
            child: PlatformIconButton(
              onPressed: () async {
                await ChannelStorage.remove(e);
                setState(() {});
              },
              icon: Icon(
                Icons.do_not_disturb_on,
                color: Colors.red,
              ),
            ),
          ),
        );
      }

      return Stack(children: stackChildren);
    }).toList();

    if (channelCells.length > 1) {
      gridChildren.add(AllChannelsGridCell());
    }

    gridChildren.addAll(channelCells);

    if (_haveLoadingItem) {
      gridChildren.add(SpinKitRotatingPlain(color: Colors.black12));
    }

    return gridChildren;
  }

  List<Widget> _getAppBarTitleView(AsyncSnapshot<List<RSSChannelModel>> snapshot) {
    List<Widget> titleView = List<Widget>();

    if (snapshot.hasData) {
      if (snapshot.data.isNotEmpty) {
        titleView.add(FlatButton(
          onPressed: () => setState(() {
            _isEdit = !_isEdit;
          }),
          child: Text(
            _isEdit ? 'done'.tr() : 'edit'.tr(),
          ),
        ));
      }
    }

    titleView.add(
        Expanded(
          child: Center(
            child: Text('rss_client').tr(),
          ),
        )
    );

    return titleView;
  }

  Widget _generateScaffoldBody(AsyncSnapshot<List<RSSChannelModel>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data.isNotEmpty) {
        return GridView.count(
          crossAxisCount: 2,
          children: _generateGridChildren(snapshot.data),
        );
      } else {
        _isEdit = false;
        return EmptyDataView(
          title: 'no_channels'.tr(),
          subtitle: 'please_add_channels'.tr(),
        );
      }
    } else {
      return SpinKitWave(
        color: Colors.black,
      );
    }
  }

  void _showEnterUrlPopUp() async {
    await showDialog(
      context: context,
      child: AddSourceDialog(
        addOnTapped: (sourceUrl) async {
          setState(() { _haveLoadingItem = true; });
          await _controller.addNewSourceUrl(sourceUrl);
          setState(() { _haveLoadingItem = false; });
        },
      )
    );
  }
}