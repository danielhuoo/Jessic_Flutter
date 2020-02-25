import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessic_flutter/loginPage.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserState provider = Provider.of<UserState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('我的账号')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Jessic'),
                        content: Text('确定退出当前账号吗？'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              provider.logout();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return LoginPage();
                              }));
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text('退出登录'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
