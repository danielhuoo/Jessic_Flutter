import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const baseURL = 'http://192.168.1.110:3000';
const url = {
  "login": '/login/cellphone',
  'getUserDetail': '/user/detail',
  'getPlayListInfo': '/user/playlist'
};

class Api {
  static post(url, body) async {
    return await http.post(baseURL + url, body: body);
  }

  static login(String phone, String password) async {
    String uid;
    final body = {'phone': phone, 'password': password};
    final response = await post(url['login'], body);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      uid = data['account']['id'].toString();
    }

    return uid;
  }

  static getUserDetail(String uid) async {
    final body = {'uid': uid};
    final response = await post(url['getUserDetail'], body);
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    return data;
  }

  static getPlayListInfo(String uid) async {
    final body = {'uid': uid};
    final response = await post(url['getPlayListInfo'], body);
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    return data;
  }
}
