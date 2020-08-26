import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class ErrorDialog extends StatelessWidget {

  final String message;

  ErrorDialog({
    Key key,
    this.message
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: Text('Error').tr(),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok').tr(),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}