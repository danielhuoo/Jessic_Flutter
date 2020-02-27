import 'package:dio/dio.dart';

const url = {
  "login": '/login/cellphone',
  'getUserDetail': '/user/detail',
  'getPlayListInfo': '/user/playlist',
  'getPlayListDetail': '/playlist/detail',
  'getSongComment': '/comment/music'
};

BaseOptions options = new BaseOptions(
  baseUrl: "http://192.168.1.110:3000",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class Api {
  static login(String phone, String password) async {
    String uid;

    try {
      Response response = await dio.get(url['login'],
          queryParameters: {'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        uid = response.data['account']['id'].toString();
        return uid;
      }
    } catch (e) {}
  }

  static getUserDetail(String uid) async {
    try {
      Response response =
          await dio.get(url['getUserDetail'], queryParameters: {'uid': uid});

      return response.data;
    } catch (e) {}
  }

  static getPlayListInfo(String uid) async {
    try {
      Response response =
          await dio.get(url['getPlayListInfo'], queryParameters: {'uid': uid});

      return response.data;
    } catch (e) {}
  }

  static getPlayListDetail(String playListId) async {
    try {
      Response response = await dio
          .get(url['getPlayListDetail'], queryParameters: {'id': playListId});
      return response.data;
    } catch (e) {}
  }

  static getSongComment(String songId, int limit) async {
    try {
      Response response = await dio
          .get(url['getSongComment'], queryParameters: {'id': songId});
      return response.data;
    } catch (e) {}
  }
}
