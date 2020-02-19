import 'package:flutter/material.dart';
import 'package:jessic_flutter/PlayerPage.dart';
import 'package:jessic_flutter/state/indexPageState.dart';
import 'package:provider/provider.dart';
import 'songList.dart';
import 'account.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> tabBodies = [
    SongListPage(),
    AccountPage(),
    PlayerPage(
      songInfo: null,
    )
  ];

  @override
  Widget build(BuildContext context) {
    IndexPageState provider = Provider.of<IndexPageState>(context);
    return Scaffold(
      body: IndexedStack(
        index: provider.selectedIndex,
        children: tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music,
              ),
              title: Text('我的')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text('账号'))
        ],
        currentIndex: provider.selectedIndex,
        selectedItemColor: Colors.red,
        onTap: (int index) {
          setState(() {
            provider.setIndex(index);
          });
        },
      ),
    );
  }
}
