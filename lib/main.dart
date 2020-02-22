import 'package:flutter/material.dart';
import 'package:jessic_flutter/HomePage.dart';
import 'package:jessic_flutter/serviceLocator.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

void main() {
  ServiceLocator.setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jessic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => UserState())],
        child: HomePage(),
      ),
    );
  }
}
