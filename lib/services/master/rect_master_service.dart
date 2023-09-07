// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/rect_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class RectMasterService {
  Future<RectMasterModel> postRectMaster(
      {required int rectId,
      required String sn,
      required int jumlahPhasa,
      required int slotModul,
      required int modulTerpasang,
      required int modulControl,
      required String merk,
      required String tipe,
      required int popId,
      required DateTime tglInstalasi}) async {
    late Uri url = UrlService().api('rect');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': rectId,
      'pop_id': popId,
      'sn': sn,
      'jumlah_phasa': jumlahPhasa,
      'merk': merk,
      'tipe': tipe,
      'slot_modul': slotModul,
      'modul_terpasang': modulTerpasang,
      'modul_control': modulControl,
      'tgl_instalasi': tglInstalasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return RectMasterModel.fromJson(data);
    } else {
      throw "Post data rect failed";
    }
  }

  Future<RectMasterModel> editRectMaster({
    required int rectId,
    required String sn,
    required int jumlahPhasa,
    required int slotModul,
    required int modulTerpasang,
    required int modulControl,
    required String merk,
    required String tipe,
    required int popId,
  }) async {
    late Uri url = UrlService().api('edit-rect');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': rectId,
      'pop_id': popId,
      'sn': sn,
      'jumlah_phasa': jumlahPhasa,
      'merk': merk,
      'tipe': tipe,
      'slot_modul': slotModul,
      'modul_terpasang': modulTerpasang,
      'modul_control': modulControl,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return RectMasterModel.fromJson(data);
    } else {
      throw "Edit data rect failed";
    }
  }
}
