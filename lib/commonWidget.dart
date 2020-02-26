import 'package:flutter/material.dart';

class CommonWidget {
  static Widget myAppBar(String titleTxt,
      {Widget leading, List<Widget> actions, Widget title}) {
    return AppBar(
        leading: leading,
        actions: actions,
        backgroundColor: Colors.grey[50],
        elevation: 1,
        brightness: Brightness.light,
        title: title == null
            ? Text(titleTxt, style: TextStyle(color: Colors.black))
            : title);
  }
}
