import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jessic_flutter/loginPage.dart';
import 'package:jessic_flutter/routes.dart';
import 'package:jessic_flutter/serviceLocator.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

void main() {
  // 显示启动画面 3秒
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
      //Flutter似乎对于命名路由的支持不是很好，传参比较麻烦。我个人认为做这套路由还不如直接用原始方法。
      onGenerateRoute: (settings) => MyRoutes.generateRoute(settings),
      home: LoginPage(),
    );
  }
}
