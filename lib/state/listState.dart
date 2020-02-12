import 'package:flutter/material.dart';
import 'package:jessic_flutter/api.dart';

class ListState extends ChangeNotifier {
  List _playList = List(); 
  get playList => _playList;

  updateState(List list) { 
    for (int i = 0; i < list.length; i++) {
      // print(i);
      var listItem = {
        'playListId':list[i]['id'],
        'playListName':list[i]['name'],
        'trackCount':list[i]['trackCount'],
        'coverImgUrl':list[i]['coverImgUrl']
      };
      _playList.add(listItem);
      print(listItem['coverImgUrl']);
    }
  }

  getState(String uid) async {
    var data = await Api.getPlayListInfo(uid);
    updateState(data['playlist']);
  }
}
