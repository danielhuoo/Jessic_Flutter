import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // print('account');
  }

  int _count = 0;
  void add() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(child: Text(_count.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
