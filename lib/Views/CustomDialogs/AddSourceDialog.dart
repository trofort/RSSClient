import 'package:flutter/material.dart';

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

  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: new Text('Add Rss Channel'),
      content: new TextField(
        autocorrect: false,
        controller: _controller,
        decoration: new InputDecoration(
          labelText: "Enter Channel's Url",
          errorText: _isValid ? null : _checkIsValid()
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              if (_checkIsValid() != 'isValid') {
                setState(() {
                  _isValid = false;
                });
                return;
              }
              Navigator.pop(context);
              if (widget.addOnTapped != null) {
                widget.addOnTapped(_controller.text.trim());
              }
            },
            child: new Text('Add')
        ),
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.cancelOnTapped != null) {
                widget.cancelOnTapped();
              }
            },
            child: new Text('Cancel')
        ),
      ],
    );
  }

  String _checkIsValid() {
    final String text = _controller.text.trim();
    if (text == null || text.isEmpty) {
      return 'Source url is empty!';
    }
    final RegExp exp = new RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$");
    if (!exp.hasMatch(text)) {
      return 'Please, enter valid url';
    }
    return 'isValid';
  }
}