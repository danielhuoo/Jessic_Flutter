import 'package:flutter/material.dart';
import 'package:jessic_flutter/api.dart';
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
    print('songlist');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserState provider = Provider.of<UserState>(context);
    return Scaffold(
        body: Center(
            child: FlatButton(
                onPressed: () {
                  // provider.post();
                },
                child: Text('歌曲'),
                color: Colors.red,
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)))));
  }
}
