import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyDataView extends StatelessWidget {

  final String title;
  final String subtitle;

  EmptyDataView({
    Key key,
    this.title,
    this.subtitle
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.black,
                  decoration: TextDecoration.none
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}