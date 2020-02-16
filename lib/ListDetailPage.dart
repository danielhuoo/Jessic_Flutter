import 'package:flutter/material.dart';
import 'api.dart';

class ListDetailPage extends StatelessWidget {
  final playListInfo;
  ListDetailPage({Key key, @required this.playListInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('歌单')), body: mainBody());
  }

  Future<List> _getState(String playListId) async {
    print('_getState');
    var data = await Api.getPlayListDetail(playListId);
    var songs = data['playlist']['tracks'];
    return songs;
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

  Widget mainBody() {
    return FutureBuilder(
        future: _getState(this.playListInfo['id'].toString()),
        builder: (BuildContext context, AsyncSnapshot<List> ss) {
          switch (ss.connectionState) {
            case ConnectionState.waiting:
              return Text('waiting');
            case ConnectionState.done:
              List<Widget> songList = List();
              songList.add(getListTile(null, -1, ss.data.length));
              for (int i = 0; i < ss.data.length; i++) {
                songList.add(getListTile(ss.data[i], i, 0));
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

  Widget getListTile(data, index, length) {
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
          child: Row(
            children: <Widget>[
              Text(
                (index + 1).toString(),
                style: TextStyle(color: Color.fromARGB(255, 151, 150, 151)),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('${data['name']}'), //(${data['alia'][0]})
                      Text(
                        '${data['ar'][0]['name']} - ${data['al']['name']}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 96, 96, 97)),
                      )
                    ],
                  ))
            ],
          ),
          onTap: () {
            print(data['id']);
          },
          behavior: HitTestBehavior.opaque);
    }

    return row;
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
