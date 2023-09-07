// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/pop_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class PopService {
  Future<List<PopModel>> getPop({required int id}) async {
    var url = UrlService().api('pop?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<PopModel> pop = List<PopModel>.from(
        data.map((e) => PopModel.fromJson(e)),
      );
      return pop;
    } else {
      throw "Get data pop failed";
    }
  }
}
