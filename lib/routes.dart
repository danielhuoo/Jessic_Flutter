import 'package:flutter/material.dart';
import 'package:jessic_flutter/ListDetailPage.dart';
import 'package:jessic_flutter/PlayerPage.dart';
import 'package:jessic_flutter/bottomNavigationWidget.dart';
import 'package:jessic_flutter/loginPage.dart';
/// 教程：https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
class MyRoutes {
  static generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return LoginPage();
        });
        break;
      case BottomNavigationWidget.routeName:
        return MaterialPageRoute(builder: (context) {
          return BottomNavigationWidget();
        });
        break;
      case ListDetailPage.routeName:
        final ListDetailPageArguments args = settings.arguments;
        return MaterialPageRoute(builder: (context) {
          return ListDetailPage(playListId: args.playListId);
        });
        break;
      case PlayerPage.routeName:
        final PlayerPageArguments args = settings.arguments;
        return MaterialPageRoute(builder: (context) {
          return PlayerPage(
              songIndex: args.songIndex, isOnlyDisplay: args.isOnlyDisplay);
        });
        break;
    }
  }
}
