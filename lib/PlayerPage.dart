import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  final songInfo;
  PlayerPage({Key key, @required this.songInfo}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  AudioPlayerState audioPlayerState;
  bool showPlayBtn = true;
  Duration audioPlayerDuration;
  initPlayerState() async {
    String url =
        'https://music.163.com/song/media/outer/url?id=${widget.songInfo['id']}.mp3';
    await audioPlayer.setUrl(url);
    playSong();
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() => audioPlayerState = s);
      print(audioPlayerState);
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => audioPlayerDuration = d);
      print('duration: $audioPlayerDuration');
    });
  }

  @override
  initState() {
    super.initState();
    initPlayerState();
  }

  @override
  deactivate() {
    super.deactivate();
    release();
  }

  playSong() {
    if (audioPlayerState != AudioPlayerState.PLAYING) {
      resume();
      setState(() {
        showPlayBtn = false;
      });
    } else {
      pause();
      setState(() {
        showPlayBtn = true;
      });
    }
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      print('play');
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      print('pause');
    }
  }

  prev() {
    print('prev');
  }

  next() {
    print('next');
  }

  release() async {
    print('release');
    await audioPlayer.release();
  }

  Widget playBtnWidget() {
    return IconButton(
      onPressed: () {
        playSong();
      },
      icon: Icon(Icons.play_circle_outline),
    );
  }

  Widget pauseBtnWidget() {
    return IconButton(
      onPressed: () {
        playSong();
      },
      icon: Icon(Icons.pause_circle_outline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.songInfo['name'])),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              child: IconButton(
            onPressed: () {
              prev();
            },
            icon: Icon(Icons.skip_previous),
          )),
          Expanded(child: showPlayBtn ? playBtnWidget() : pauseBtnWidget()),
          Expanded(
              child: IconButton(
            onPressed: () {
              next();
            },
            icon: Icon(Icons.skip_next),
          ))
        ],
      ),
    );
  }
}
