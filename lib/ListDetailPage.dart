import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jessic_flutter/MusicService.dart';
import 'package:jessic_flutter/PlayerPage.dart';
import 'api.dart';

class ListDetailPage extends StatefulWidget {
  final String playListId;
  ListDetailPage({Key key, @required this.playListId}) : super(key: key);
  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  var playListInfo;
  final playerInstance = GetIt.instance.get<MusicServiceModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('歌单'),
            actions: <Widget>[
              // Text('正在播放')
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return PlayerPage(songIndex: null, isOnlyDisplay: true);
                    }));
                  },
                  icon: Icon(Icons.add))
            ]),
        body: mainBody(context));
  }

  Future _getState() async {
    var data = await Api.getPlayListDetail(widget.playListId);
    return data['playlist'];
  }

  String getAlias(data) {
    String alias = '';
    for (int i = 0; i < data['alia'].length; i++) {
      alias += data['alia'][i];
    }

    if (alias != '') {
      alias = '(' + alias + ')';
    }
    return alias;
  }

  Widget playListInfoWidget() {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(children: <Widget>[
          playListImgWidget(),
          Expanded(
            child: Container(
                height: 150,
                // decoration: BoxDecoration(
                //   color: Colors.grey,
                // ),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ListView(shrinkWrap: true, children: <Widget>[
                  Text(
                    this.playListInfo['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(children: <Widget>[
                      ClipOval(
                          child: new Image.network(
                        this.playListInfo['creator']['avatarUrl'],
                        width: 30,
                      )),
                      Text(
                        '  ${this.playListInfo['creator']['nickname']}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(Icons.navigate_next)
                    ]),
                  ),
                ])),
          )
        ]));
  }

  Widget fourBtnsWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Flex(children: <Widget>[
        Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  print('评论');
                },
                child: Container(
                    child: Column(
                        children: <Widget>[Icon(Icons.comment), Text('评论')])))),
        Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  print('分享');
                },
                child: Container(
                    child: Column(
                        children: <Widget>[Icon(Icons.share), Text('分享')])))),
        Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  print('下载');
                },
                child: Container(
                    child: Column(children: <Widget>[
                  Icon(Icons.file_download),
                  Text('下载')
                ])))),
        Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  print('多选');
                },
                child: Container(
                    child: Column(children: <Widget>[
                  Icon(Icons.select_all),
                  Text('多选')
                ])))),
      ], direction: Axis.horizontal),
    );
  }

  Widget getListWidget(data) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return data[index];
            },
            itemExtent: 60.0,
            itemCount: data.length,
            padding: EdgeInsets.all(10)),
      ),
    );
  }

  Widget mainBody(context) {
    return FutureBuilder(
        future: _getState(),
        builder: (BuildContext context, AsyncSnapshot ss) {
          switch (ss.connectionState) {
            case ConnectionState.waiting:
              return Text('waiting');
            case ConnectionState.done:
              List<Widget> songList = List();
              this.playListInfo = ss.data;
              var songs = this.playListInfo['tracks'];
              songList.add(getListTile(null, null, -1, songs.length));

              for (int i = 0; i < songs.length; i++) {
                songList.add(getListTile(context, songs[i], i, 0));
              }

              return Column(
                children: <Widget>[
                  //歌单详情
                  playListInfoWidget(),
                  //四个按钮
                  fourBtnsWidget(),
                  //歌曲列表
                  getListWidget(songList)
                ],
              );
            default:
              return Text('');
          }
        });
  }

  Widget getListTile(context, data, index, length) {
    Widget row;
    if (index == -1) {
      //播放全部
      row = GestureDetector(
          child: Row(
            children: <Widget>[
              Icon(Icons.play_arrow),
              Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 0, 0), child: Text('播放全部')),
              Text(
                '(共${length.toString()}首)',
                style: TextStyle(color: Color.fromARGB(255, 143, 143, 143)),
              )
            ],
          ),
          onTap: () {
            print(length);
          },
          behavior: HitTestBehavior.opaque);
    } else {
      row = GestureDetector(
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  flex: 0,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(color: Color.fromARGB(255, 151, 150, 151)),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flex(
                            direction: Axis.horizontal,
                            children: songNameWidget(data),
                          ),
                          Text(
                            '${data['ar'][0]['name']} - ${data['al']['name']}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 96, 96, 97)),
                          )
                        ],
                      )))
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              playerInstance.updatePlayList(this.playListInfo);
              return PlayerPage(songIndex: index, isOnlyDisplay: false);
            }));
          },
          behavior: HitTestBehavior.opaque);
    }

    return row;
  }

  List<Widget> songNameWidget(data) {
    bool isCurrentSong = false;
    //如果当前没有播放音乐。那么songInfo是null的
    if (playerInstance.songInfo != null) {
      isCurrentSong = data['id'] == playerInstance.songInfo['id'];
    }

    return <Widget>[
      Expanded(
        flex: 0,
        child: Text(data['name'],
            style: TextStyle(color: isCurrentSong ? Colors.red : Colors.black)),
      ),
      Expanded(
          flex: 1,
          child: Text(
            getAlias(data),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: isCurrentSong
                    ? Colors.red
                    : Color.fromARGB(255, 96, 96, 97)),
          ))
    ];
  }

  Widget playListImgWidget() {
    return Container(
      child: Image.network(
        this.playListInfo['coverImgUrl'],
        width: 150,
        height: 150,
      ),
    );
  }
}
