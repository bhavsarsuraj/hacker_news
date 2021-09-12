import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final Function onTapTitle;

  const BaseScaffold({
    Key key,
    this.appBarTitle,
    @required this.body,
    this.onTapTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: onTapTitle,
          child: appBarTitle != null
              ? Text(
                  appBarTitle,
                  style: TextStyle(color: Colors.black),
                )
              : Container(),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
