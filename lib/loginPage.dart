import 'package:flutter/material.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';
import 'api.dart';
class LoginPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    UserState provider = Provider.of<UserState>(context);

    TextEditingController _phone = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    _phone.text = '18002280851';
    _password.text = 'abc12345';

    return Scaffold(
      appBar: AppBar(
        title: Text('手机号登录',style: TextStyle(color:Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        ),
      body:Center(
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
                onPressed:() async{
                  provider.getState(_phone.text, _password.text);
                },
                child:Text('立即登录'),
                color:Colors.red,
                colorBrightness: Brightness.dark,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
              )
            ],
          ),
          padding: const EdgeInsets.all(10.0),
        ),
      )
    );
  }
}
