import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jessic_flutter/MusicService.dart';
import 'package:jessic_flutter/commonWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Slider api: https://blog.csdn.net/qq_33635385/article/details/100067702

class PlayerPage extends StatefulWidget {
  final songIndex;
  final bool isOnlyDisplay;
  PlayerPage({Key key, @required this.songIndex, this.isOnlyDisplay})
      : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  var playerInstance = GetIt.instance.get<MusicServiceModel>();
  @override
  initState() {
    super.initState();
    playerInstance.addListener(update);
    if (widget.isOnlyDisplay != true) {
      playerInstance.init(widget.songIndex);
    } else {
      print('仅显示播放页');
    }
  }

  update() => setState(() => {});

  @override
  void dispose() {
    playerInstance.removeListener(update);
    super.dispose();
  }

  Widget playBtnWidget() {
    return IconButton(
      iconSize: 70.0,
      onPressed: () {
        playerInstance.playSong();
      },
      icon: Icon(Icons.play_circle_outline),
    );
  }

  Widget pauseBtnWidget() {
    return IconButton(
      iconSize: 70.0,
      onPressed: () {
        playerInstance.playSong();
      },
      icon: Icon(Icons.pause_circle_outline),
    );
  }

  PanelController _controller = new PanelController();
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  String getTotalCommentsNum() {
    int num = 0;
    if (playerInstance.commentInfo != null) {
      num = playerInstance.commentInfo['total'];
    }
    return num.toString() + '条评论';
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    child: Image.network(
                  playerInstance.songInfo['al']['picUrl'],
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
                        playerInstance.prev();
                      },
                      icon: Icon(Icons.favorite),
                    )),
                    Expanded(
                        child: IconButton(
                      iconSize: 27.0,
                      onPressed: () {
                        // playerInstance.prev();
                        print(_controller.open());
                      },
                      icon: Icon(Icons.comment),
                    )),
                    Expanded(
                        child: IconButton(
                      iconSize: 27.0,
                      onPressed: () {
                        playerInstance.prev();
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
                    Expanded(flex: 1, child: Text(playerInstance.positionText)),
                    Expanded(
                        flex: 5,
                        child: SliderTheme(
                            data: SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 4.0,
                                    disabledThumbRadius: 3.0)),
                            child: Slider(
                              value: playerInstance.progressValue,
                              onChanged: (double nv) {},
                            ))),
                    Expanded(flex: 1, child: Text(playerInstance.durationText)),
                  ],
                )),
            //播放按钮
            Expanded(
                flex: 0,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    // Expanded(
                    //     flex: 1,
                    //     child: IconButton(
                    //       iconSize: 40.0,
                    //       onPressed: () {
                    //         playerInstance.prev();
                    //       },
                    //       icon: Icon(Icons.repeat),
                    //     )),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {
                            playerInstance.prev();
                          },
                          icon: Icon(Icons.skip_previous),
                        )),
                    Expanded(
                        flex: 1,
                        child: playerInstance.showPlayBtn
                            ? playBtnWidget()
                            : pauseBtnWidget()),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {
                            playerInstance.next();
                          },
                          icon: Icon(Icons.skip_next),
                        )),
                    // Expanded(
                    //     flex: 1,
                    //     child: IconButton(
                    //       iconSize: 40.0,
                    //       onPressed: () {
                    //         playerInstance.next();
                    //       },
                    //       icon: Icon(Icons.playlist_play),
                    //     ))
                  ],
                )),
          ],
        ));
    return Scaffold(
        appBar: CommonWidget.myAppBar(
          '',
          title: Column(children: <Widget>[
            Text(
              playerInstance.songInfo['name'],
              style: TextStyle(fontSize: 17),
            ),
            Text('${playerInstance.songInfo['ar'][0]['name']}',
                style: TextStyle(fontSize: 15))
          ]),
        ),
        body: Stack(children: <Widget>[
          body,
          SlidingUpPanel(
            backdropEnabled: true,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            panel: Column(children: <Widget>[
              Text(getTotalCommentsNum()),
            ]),
            controller: _controller,
            defaultPanelState: PanelState.CLOSED,
            minHeight: 0,
            maxHeight: 500,
            borderRadius: radius,
          )
        ]));
  }
}
