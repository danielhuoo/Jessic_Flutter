import 'package:flutter/material.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';
import 'api.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Future<List> _getState(String uid) async {
    print('_getState');
    var data = await Api.getPlayListInfo(uid);
    var list = data['playlist'];
    List _list = List();
    for (int i = 0; i < list.length; i++) {
      var listItem = {
        'playListId': list[i]['id'],
        'playListName': list[i]['name'].toString(),
        'trackCount': list[i]['trackCount'].toString(),
        'coverImgUrl': list[i]['coverImgUrl'].toString()
      };
      _list.add(listItem);
    }

    return _list;
  }

  Widget getGridWidget(data) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 1.5),
        itemBuilder: (context, index) {
          return data[index];
        },
        itemCount: data.length);
  }

  Widget getRowItem(data) {
    return Row(
      children: <Widget>[
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data['coverImgUrl'],
              width: 80.0,
              height: 80.0,
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data['playListName']),
                Text('${data['trackCount']}首')
              ]),
        ))
      ],
    );
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
              List<Widget> playList = List();
              for (int i = 0; i < ss.data.length; i++) {
                playList.add(getRowItem(ss.data[i]));
              }

              return getGridWidget(playList);
            default:
              return Text('11');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserState provider = Provider.of<UserState>(context);
    return Scaffold(
        appBar: AppBar(title: Text('歌单列表')),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: getMainBody(provider.uid)));
  }
}
