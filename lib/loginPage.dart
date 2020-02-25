import 'package:flutter/material.dart';
import 'package:jessic_flutter/bottomNavigationWidget.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserState provider = Provider.of<UserState>(context);
    TextEditingController _phone = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    _phone.text = '18002280851';
    _password.text = 'abc12345';

    void goHomePage() async {
      var isLogined = await provider.getState(_phone.text, _password.text);
      if (isLogined) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return BottomNavigationWidget();
        }));
      }
    }

    //For test
    // goHomePage();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '手机号登录',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightBlue,
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  // autofocus: true,
                  decoration: InputDecoration(labelText: "输入手机号"),
                  controller: _phone,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "输入密码"),
                  obscureText: true,
                  controller: _password,
                ),
                FlatButton(
                    onPressed: () async {
                      goHomePage();
                    },
                    child: Text('立即登录'),
                    color: Colors.red,
                    colorBrightness: Brightness.dark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)))
              ],
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ));
  }
}
