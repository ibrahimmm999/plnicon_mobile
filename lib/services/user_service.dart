// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/services/url_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  Future<void> setTokenPreference(String token) async {
    final pref = await SharedPreferences.getInstance();
    await clearTokenPreference();
    pref.setString('token', token);
  }

  Future<String?> getTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> clearTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      pref.clear();
    }
  }

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    var url = UrlService().api('login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user =
          UserModel.fromJson(data['user'], 'Bearer ${data['acess_token']}');
      await setTokenPreference(user.token);
      return user;
    } else {
      throw jsonDecode(response.body)['data']['error'];
    }
  }

  Future<bool> logout({required String token}) async {
    var url = UrlService().api('logout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      await clearTokenPreference();
      return true;
    } else {
      throw jsonDecode(response.body)['data']['error'];
    }
  }

  Future<UserModel> getUser({required String token}) async {
    var url = UrlService().api('user');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data, token);
      return user;
    } else {
      throw "Get user failed";
    }
  }
}
