import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// example : https://github.com/luanpotter/audioplayers/blob/master/example/lib/player_widget.dart
// Slider api: https://blog.csdn.net/qq_33635385/article/details/100067702
// app bar : https://blog.csdn.net/it_xiaoshuai/article/details/87718827

class PlayerPage extends StatefulWidget {
  final songInfo;
  PlayerPage({Key key, @required this.songInfo}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with AutomaticKeepAliveClientMixin {
  AudioPlayer audioPlayer;

  AudioPlayerState audioPlayerState;
  bool showPlayBtn = true;
  Duration audioPlayerDuration;
  Duration audioPlayerPosition;
  double progressValue = 0.0;

  StreamSubscription durationSubscription;
  StreamSubscription positionSubscription;
  StreamSubscription completeSubscription;

  String durationText = '';
  String positionText = '';

  void initPlayerState() async {
    print('initPlayerState');

    //init durationText & positionText to 0:00:00
    Duration zeroDuration = Duration(hours: 0, minutes: 0, seconds: 0);
    positionText = durationText =
        zeroDuration?.toString()?.split('.')?.first?.substring(2);

    //create the instance of audioplayer
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() => audioPlayerState = s);
    });

    durationSubscription = audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration================= $d');
      setState(() {
        audioPlayerDuration = d;
        durationText = d?.toString()?.split('.')?.first?.substring(2) ?? '';
      });
    });

    positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        audioPlayerPosition = p;
        positionText = p?.toString()?.split('.')?.first?.substring(2) ?? '';
        try {
          progressValue =
              audioPlayerPosition.inSeconds / audioPlayerDuration.inSeconds;
        } catch (e) {}
      });
    });

    completeSubscription = audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      next();
    });

    String url =
        'https://music.163.com/song/media/outer/url?id=${widget.songInfo['id']}.mp3';
    // String url = 'https://music.163.com/song/media/outer/url?id=158655.mp3';
    int result = await audioPlayer.setUrl(url);
    if (result == 1) {
      // playSong();
    }
  }

  @override
  initState() {
    super.initState();
    if (widget.songInfo != null) {
      initPlayerState();
    }
  }

  // @override
  // void dispose() {
  //   print('dipose');
  //   audioPlayer.stop();
  //   durationSubscription.cancel();
  //   positionSubscription.cancel();
  //   completeSubscription.cancel();
  //   super.dispose();
  // }

  playSong() {
    if (audioPlayerState != AudioPlayerState.PLAYING) {
      resume();
    } else {
      pause();
    }
  }

  void _onComplete() {
    //state会变为 AudioPlayerState.COMPLETED
    // print('state:${audioPlayerState}');
    setState(() {
      showPlayBtn = true;
    });
    // setState(() {
    //   audioPlayerState =
    // });
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      print('play');
      setState(() {
        showPlayBtn = false;
      });
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      print('pause');
      setState(() {
        showPlayBtn = true;
      });
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
      iconSize: 70.0,
      onPressed: () {
        playSong();
      },
      icon: Icon(Icons.play_circle_outline),
    );
  }

  Widget pauseBtnWidget() {
    return IconButton(
      iconSize: 70.0,
      onPressed: () {
        playSong();
      },
      icon: Icon(Icons.pause_circle_outline),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.songInfo == null) {
      print('空白页');
      return Scaffold(appBar: AppBar(title: Text('空白页')));
    }
    return Scaffold(
        // appBar: AppBar(title: ),
        appBar: AppBar(
          title: Column(children: <Widget>[
            Text(
              widget.songInfo['name'],
              style: TextStyle(fontSize: 17),
            ),
            Text('${widget.songInfo['ar'][0]['name']}',
                style: TextStyle(fontSize: 15))
          ]),
        ),
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
                //喜欢按钮们
                Expanded(
                    flex: 0,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                            child: IconButton(
                          color: Colors.red,
                          iconSize: 27.0,
                          onPressed: () {
                            prev();
                          },
                          icon: Icon(Icons.favorite),
                        )),
                        Expanded(
                            child: IconButton(
                          iconSize: 27.0,
                          onPressed: () {
                            prev();
                          },
                          icon: Icon(Icons.comment),
                        )),
                        Expanded(
                            child: IconButton(
                          iconSize: 27.0,
                          onPressed: () {
                            prev();
                          },
                          icon: Icon(Icons.more_vert),
                        )),
                      ],
                    )),
                //进度条
                Expanded(
                    flex: 0,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(flex: 1, child: Text(positionText)),
                        Expanded(
                            flex: 5,
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
                        Expanded(flex: 1, child: Text(durationText)),
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
                          iconSize: 40.0,
                          onPressed: () {
                            prev();
                          },
                          icon: Icon(Icons.repeat),
                        )),
                        Expanded(
                            child: IconButton(
                          iconSize: 40.0,
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
                          iconSize: 40.0,
                          onPressed: () {
                            next();
                          },
                          icon: Icon(Icons.skip_next),
                        )),
                        Expanded(
                            child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {
                            next();
                          },
                          icon: Icon(Icons.playlist_play),
                        ))
                      ],
                    )),
              ],
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
