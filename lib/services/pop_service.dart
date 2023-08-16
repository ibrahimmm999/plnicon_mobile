// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/pop_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;

class PopService {
  Future<List<PopModel>> getPop(
      {required String token, required int id}) async {
    var url = UrlService().api('pop?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      print("DATA");
      print(data[0]['pdb']);
      List<PopModel> pop = List<PopModel>.from(
        data.map((e) => PopModel.fromJson(e)),
      );
      print("XXX");
      return pop;
    } else {
      throw "Get data pop failed";
    }
  }
}
