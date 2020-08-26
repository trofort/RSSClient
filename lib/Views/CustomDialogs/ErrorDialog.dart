import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ErrorDialog extends StatelessWidget {

  final String message;

  ErrorDialog({
    Key key,
    this.message
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      android: (_) => MaterialAlertDialogData(
        contentPadding: EdgeInsets.all(16.0)
      ),
      title: Text(
        'error',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ).tr(),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'ok',
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.bold
            ),
          ).tr(),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}