// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/pdb_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class PdbMasterService {
  Future<PdbMasterModel> postPdbMaster(
      {required int pdbId,
      required String nama,
      required String tipe,
      required String arester,
      required String aresterTipe,
      required int popId,
      required DateTime tglInstalasi}) async {
    late Uri url = UrlService().api('pdb');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': pdbId,
      'pop_id': popId,
      'nama': nama,
      'arester_tipe': aresterTipe,
      'arester': arester,
      'tipe': tipe,
      'tgl_instalasi': tglInstalasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PdbMasterModel.fromJson(data);
    } else {
      throw "Post data pdb failed";
    }
  }

  Future<PdbMasterModel> deletePdbMaster({required int id}) async {
    late Uri url = UrlService().api('delete-pdb');

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
        var data = jsonDecode(response.body)['data'];
        return PdbMasterModel.fromJson(data);
      } else {
        throw "Delete data pdb failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PdbMasterModel> editPdbMaster({
    required int pdbId,
    required String nama,
    required String tipe,
    required String arester,
    required String aresterTipe,
    required int popId,
  }) async {
    late Uri url = UrlService().api('edit-pdb');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': pdbId,
      'pop_id': popId,
      'nama': nama,
      'arester_tipe': aresterTipe,
      'arester': arester,
      'tipe': tipe,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PdbMasterModel.fromJson(data);
    } else {
      throw "Edit data pdb failed";
    }
  }
}
