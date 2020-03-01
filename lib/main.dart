import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jessic_flutter/loginPage.dart';
import 'package:jessic_flutter/serviceLocator.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

void main() {
  // 显示启动画面 3秒.
  Timer(Duration(seconds: 3), () {
    ServiceLocator.setupLocator();
    runApp(MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => UserState())],
        child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Jessic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => BottomNavigationWidget(),
      //   '/login': (context) => LoginPage()
      // },
      home: LoginPage(),
    );
  }
}
