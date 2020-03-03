import 'package:flutter/material.dart';
import 'songList.dart';
import 'account.dart';

class BottomNavigationWidget extends StatefulWidget {
  static const routeName = '/mainPage';
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> tabBodies = [
    SongListPage(),
    AccountPage()
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
