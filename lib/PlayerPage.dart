import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// Slider api: https://blog.csdn.net/qq_33635385/article/details/100067702

class PlayerPage extends StatefulWidget {
  final songInfo;
  PlayerPage({Key key, @required this.songInfo}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  AudioPlayer audioPlayer;

  AudioPlayerState audioPlayerState;
  bool showPlayBtn = true;
  Duration audioPlayerDuration;
  Duration audioPlayerPosition;
  double progressValue = 0.0;

  StreamSubscription durationSubscription;
  StreamSubscription positionSubscription;

  String durationText = '';
  String positionText = '0:00:00';

  void initPlayerState() async {
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() => audioPlayerState = s);
    });

    durationSubscription = audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration================= $d');
      setState(() {
        audioPlayerDuration = d;
        durationText = d?.toString()?.split('.')?.first ?? '';
      });
    });

    positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        audioPlayerPosition = p;
        positionText = p?.toString()?.split('.')?.first ?? '';
        try {
          progressValue =
              audioPlayerPosition.inSeconds / audioPlayerDuration.inSeconds;
        } catch (e) {}
      });
    });

    String url =
        'https://music.163.com/song/media/outer/url?id=${widget.songInfo['id']}.mp3';
    int result = await audioPlayer.setUrl(url);
    if (result == 1) {
      playSong();
    }
  }

  @override
  initState() {
    super.initState();
    print(widget.songInfo);
    initPlayerState();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    durationSubscription.cancel();
    positionSubscription.cancel();
    super.dispose();
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
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                        child: Image.network(
                      widget.songInfo['al']['picUrl'],
                      // width: 50,
                    ))),
                //进度条
                Expanded(
                    flex: 0,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(flex: 0, child: Text(positionText)),
                        Expanded(
                            child: SliderTheme(
                                data: SliderThemeData(
                                    trackHeight: 1,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 4.0,
                                        disabledThumbRadius: 3.0)),
                                child: Slider(
                                  value: this.progressValue,
                                  onChanged: (double nv) {},
                                ))),
                        Expanded(flex: 0, child: Text(durationText)),
                      ],
                    )),
                //播放按钮
                Expanded(
                    flex: 0,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                            child: IconButton(
                          onPressed: () {
                            prev();
                          },
                          icon: Icon(Icons.skip_previous),
                        )),
                        Expanded(
                            child: showPlayBtn
                                ? playBtnWidget()
                                : pauseBtnWidget()),
                        Expanded(
                            child: IconButton(
                          onPressed: () {
                            next();
                          },
                          icon: Icon(Icons.skip_next),
                        ))
                      ],
                    )),
              ],
            )));
  }
}
