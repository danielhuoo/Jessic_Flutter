import 'package:flutter/material.dart';

import 'api.dart';

class ListDetailPage extends StatelessWidget {
  final String playListId;
  ListDetailPage({Key key, @required this.playListId}) : super(key: key);

  Future<List> _getState(String playListId) async {
    print('_getState');
    var data = await Api.getPlayListDetail(playListId);
    var songs = data['playlist']['tracks'];
    print(songs.length);
    return songs;
  }

  Widget getMainBody(data) {
    return FutureBuilder(
        future: _getState(data),
        builder: (BuildContext context, AsyncSnapshot<List> ss) {
          switch (ss.connectionState) {
            case ConnectionState.waiting:
              // print('waiting');
              return Text('waiting');
            case ConnectionState.done:
              List<Widget> songList = List();
              songList.add(getListTile(null, -1, ss.data.length));
              for (int i = 0; i < ss.data.length; i++) {
                songList.add(getListTile(ss.data[i], i, 0));
              }

              return getListWidget(songList);
            default:
              return Text('11');
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
                      Text(data['name']),
                      Text(
                        data['ar'][0]['name'],
                        style:
                            TextStyle(color: Color.fromARGB(255, 96, 96, 97)),
                      )
                    ],
                  ))
            ],
          ),
          onTap: () {
            print(index);
          },
          behavior: HitTestBehavior.opaque);
    }

    return row;
  }

  Widget getListWidget(data) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return data[index];
        },
        itemExtent: 60.0,
        itemCount: data.length,
        padding: EdgeInsets.all(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('歌单详情')),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: getMainBody(this.playListId)));
  }
}
