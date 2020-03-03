import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jessic_flutter/MusicService.dart';
import 'package:jessic_flutter/PlayerPage.dart';

class CommonWidget {
  /// Return the common Widget of AppBar
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

  /// Return the nowPlayingButton. Only the playerInstance has songInfo, the button is enabled.
  static Widget nowPlayingButton(context) {
    var playerInstance = GetIt.instance.get<MusicServiceModel>();
    var onPressedFunc;
    if (playerInstance.songInfo != null) {
      onPressedFunc = () {
        Navigator.pushNamed(context, PlayerPage.routeName,
            arguments: PlayerPageArguments(null, true));
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
