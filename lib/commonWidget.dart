import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jessic_flutter/MusicService.dart';
import 'package:jessic_flutter/PlayerPage.dart';

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

  static Widget nowPlayingButton(context) {
    var playerInstance = GetIt.instance.get<MusicServiceModel>();
    var onPressedFunc;
    if (playerInstance.songInfo != null) {
      onPressedFunc = () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return PlayerPage(songIndex: null, isOnlyDisplay: true);
        }));
      };
    } else {
      onPressedFunc = null;
    }

    return IconButton(
        color: Colors.red,
        onPressed: onPressedFunc,
        disabledColor: Colors.grey,
        icon: Icon(
          Icons.music_note,
        ));
  }
}
