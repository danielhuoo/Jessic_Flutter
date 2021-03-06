import 'package:flutter/material.dart';
import 'package:jessic_flutter/ListDetailPage.dart';
import 'package:jessic_flutter/commonWidget.dart';
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
  Widget build(BuildContext context) {
    super.build(context);
    UserState provider = Provider.of<UserState>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonWidget.myAppBar('歌单列表',
            actions: <Widget>[CommonWidget.nowPlayingButton(context)]),
        body: mainBody(provider.uid));
  }

  Future<List> _getState(String uid) async {
    var data = await Api.getPlayListInfo(uid);
    var list = data['playlist'];
    return list;
  }

  Widget mainBody(data) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: FutureBuilder(
            future: _getState(data),
            builder: (BuildContext context, AsyncSnapshot<List> ss) {
              switch (ss.connectionState) {
                case ConnectionState.waiting:
                  return Text('waiting');
                case ConnectionState.done:
                  List<Widget> playList = List();
                  for (int i = 0; i < ss.data.length; i++) {
                    playList.add(getRowItem(ss.data[i]));
                  }
                  return gridWidget(playList);
                default:
                  return Text('11');
              }
            }));
  }

  Widget gridWidget(data) {
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
    return GestureDetector(
        child: Row(
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
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data['name'],
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text(
                      '${data['trackCount']}首',
                      style:
                          TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                    )
                  ]),
            ))
          ],
        ),
        onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (BuildContext context) {
          //   return ListDetailPage(playListId: data['id'].toString());
          // }));

          Navigator.pushNamed(context, ListDetailPage.routeName,
              arguments: ListDetailPageArguments(data['id'].toString()));
        });
  }
}
