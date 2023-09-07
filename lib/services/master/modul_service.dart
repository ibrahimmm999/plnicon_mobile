// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/modul_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class ModulMasterService {
  Future<ModulMasterModel> postMModulMaster({
    required int modulId,
    required String rectId,
    required String kapasitas,
    required String sn,
    required int popId,
  }) async {
    late Uri url = UrlService().api('modul');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': modulId,
      'pop_id': popId,
      'rect_id': rectId,
      'sn': sn,
      'kapasitas': kapasitas,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return ModulMasterModel.fromJson(data);
    } else {
      throw "Post data modul failed";
    }
  }

  Future<ModulMasterModel> editModulMaster({
    required int modulId,
    required String rectId,
    required String kapasitas,
    required String sn,
    required int popId,
  }) async {
    late Uri url = UrlService().api('edit-modul');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': modulId,
      'pop_id': popId,
      'rect_id': rectId,
      'sn': sn,
      'kapasitas': kapasitas,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return ModulMasterModel.fromJson(data);
    } else {
      throw "Edit data modul failed";
    }
  }
}
