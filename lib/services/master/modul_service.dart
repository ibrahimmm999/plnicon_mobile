// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/modul_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class ModulMasterService {
  Future<ModulMasterModel> postModulMaster({
    required int rectId,
    required int kapasitas,
    required String sn,
  }) async {
    late Uri url = UrlService().api('modul');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
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

  Future<bool> deleteMaster({required int id}) async {
    late Uri url = UrlService().api('delete-modul');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': id,
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Delete data modul failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ModulMasterModel> editModulMaster({
    required int modulId,
    required int rectId,
    required int kapasitas,
    required String sn,
  }) async {
    late Uri url = UrlService().api('edit-modul');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': modulId,
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
