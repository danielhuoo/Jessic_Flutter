import 'package:flutter/material.dart';
import 'songList.dart';
import 'account.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  final List<Widget> tabBodies = [SongListPage(), AccountPage()];

  @override
  void initState() {
    super.initState();
    print('bottom');
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