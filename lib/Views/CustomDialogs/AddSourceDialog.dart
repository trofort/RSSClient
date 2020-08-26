import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return new AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: new Text('add_rss_channel').tr(),
      content: new TextField(
        autocorrect: false,
        controller: _controller,
        decoration: new InputDecoration(
          labelText: "enter_channels_url".tr(),
          errorText: _validationError == null ? null : _validationError.cause
        ),
      ),
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
              } finally {
                setState(() {});
              }
            },
            child: new Text('add').tr()
        ),
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.cancelOnTapped != null) {
                widget.cancelOnTapped();
              }
            },
            child: new Text('cancel').tr()
        ),
      ],
    );
  }


}