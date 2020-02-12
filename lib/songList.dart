import 'package:flutter/material.dart';
import 'package:jessic_flutter/state/listState.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

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
    // listStateProvider.getState(userStateProvider.uid);
    print('songlist');
  }

  @override
  Widget build(BuildContext context) {
    print('111');
    super.build(context);
    ListState listStateProvider = Provider.of<ListState>(context);
    UserState userStateProvider = Provider.of<UserState>(context);

    listStateProvider.getState(userStateProvider.uid);
    return Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: 0.7
              ),
          itemBuilder: (context, index) {
            return Image.network(listStateProvider.playList[index]['coverImgUrl']);
            // return Image(
            //   image:NetworkImage(listStateProvider.playList[index]['coverImgUrl']),
            //   width:25.0            
            // );
          },
          itemCount: listStateProvider.playList.length,
    ));
  }
}
