import 'package:flutter/material.dart';
import 'package:jessic_flutter/bottomNavigationWidget.dart';
import 'package:jessic_flutter/loginPage.dart';
import 'package:jessic_flutter/state/userState.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserState provider = Provider.of<UserState>(context);
    return Scaffold(
        body: provider.isLogined ? BottomNavigationWidget() : LoginPage()
        );
  }
}
