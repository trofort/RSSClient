import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:rss_client/Exceptions/URLValidationException/URLValidationException.dart';
import 'package:rss_client/Services/URLValidationService.dart';

class AddSourceDialog extends StatefulWidget {

  final Function(String) addOnTapped;
  final VoidCallback cancelOnTapped;

  AddSourceDialog({
    Key key,
    this.addOnTapped,
    this.cancelOnTapped
  });

  createState() => _AddSourceDialogState();
}

class _AddSourceDialogState extends State<AddSourceDialog> {

  final TextEditingController _controller = new TextEditingController();

  URLValidationException _validationError;

  @override
  Widget build(BuildContext context) {
    return new PlatformAlertDialog(
      android: (_) => MaterialAlertDialogData(
        contentPadding: EdgeInsets.all(16.0),
        content: new TextField(
          autocorrect: false,
          controller: _controller,
          decoration: new InputDecoration(
              labelText: "enter_channels_url".tr(),
              errorText: _validationError == null ? null : _validationError.cause
          ),
        ),
      ),
      ios: (_) => CupertinoAlertDialogData(
        content: Cupertino.Container(
          child: Cupertino.Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Cupertino.Text(
                _validationError == null ? "" : _validationError.cause,
                style: Cupertino.TextStyle(
                  color: Colors.red,
                  fontSize: 10.0
                ),
              ),
              Cupertino.CupertinoTextField(
                autocorrect: false,
                controller: _controller,
                placeholder: "enter_channels_url".tr(),
                decoration: Cupertino.BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Cupertino.CupertinoColors.systemGrey2,
                  ),
                  borderRadius: Cupertino.BorderRadius.all(Cupertino.Radius.circular(5.0))
                ),
              )
            ],
          ),
        )
      ),
      title: new Text('add_rss_channel').tr(),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              try {
                URLValidationService.isValidUrl(_controller.text);
                _validationError = null;
                Navigator.pop(context);
                if (widget.addOnTapped != null) {
                  widget.addOnTapped(_controller.text.trim());
                }
              } on URLValidationException catch(error) {
                _validationError = error;
              } catch (error) {
                print('Catch: $error');
              }
              finally {
                setState(() {});
              }
            },
            child: new Text(
              'add',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Cupertino.CupertinoColors.activeBlue
              ),
            ).tr()
        ),
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.cancelOnTapped != null) {
                widget.cancelOnTapped();
              }
            },
            child: new Text(
              'cancel',
              style: TextStyle(
                  color: Cupertino.CupertinoColors.activeBlue
              ),
            ).tr()
        ),
      ],
    );
  }


}