// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/mcb_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class McbMasterService {
  Future<McbMasterModel> postMcbMaster(
      {required int popId,
      required int pdbId,
      required String nama,
      required String merk,
      required String jumlahPhasa,
      required String kapasitas,
      required String tipe,
      String? peruntukan,
      required String aTerukur,
      String? tglInstalasi}) async {
    late Uri url = UrlService().api('mcb');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'pdb_id': pdbId,
      'nama': nama,
      'merk': merk,
      'jumlah_phasa': jumlahPhasa,
      'a_terukur': aTerukur,
      'kapasitas': kapasitas,
      'tipe': tipe,
      'peruntukan': peruntukan,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return McbMasterModel.fromJson(data);
    } else {
      throw "Post data mcb failed";
    }
  }

  Future<McbMasterModel> editMcbMaster({
    required int mcbId,
    required int popId,
    required int pdbId,
    required String nama,
    required String merk,
    required String jumlahPhasa,
    required String kapasitas,
    required String tipe,
    required String peruntukan,
    String? tglInstalasi,
    required String aTerukur,
  }) async {
    late Uri url = UrlService().api('edit-mcb');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': mcbId,
      'pop_id': popId,
      'pdb_id': pdbId,
      'nama': nama,
      'merk': merk,
      'jumlah_phasa': jumlahPhasa,
      'a_terukur': aTerukur,
      'kapasitas': kapasitas,
      'tipe': tipe,
      'peruntukan': peruntukan,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return McbMasterModel.fromJson(data);
    } else {
      throw "Edit data mcb failed";
    }
  }

  Future<bool> deleteMaster({required int id}) async {
    late Uri url = UrlService().api('delete-mcb');

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
        throw "Delete data failed";
      }
    } catch (e) {
      rethrow;
    }
  }
}
