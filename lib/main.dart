import 'package:flutter/material.dart';
import 'package:jessic_flutter/HomePage.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jessic',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserState())
          ],
        child: HomePage(),
      ),
    );
  }
}
