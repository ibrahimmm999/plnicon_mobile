// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/ats_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class AtsMasterService {
  Future<AtsMasterModel> postAtsMaster({
    required String status,
    required String sn,
    required String merk,
    required String tipe,
    required int popId,
  }) async {
    late Uri url = UrlService().api('ats');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'status': status,
      'sn': sn,
      'merk': merk,
      'tipe': tipe,
      'tgl_instalasi': DateFormat("yyyy-MM-dd'T'HH:mm:ss.ssssssZ")
          .parse("2021-01-03T18:42:49.608466Z")
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return AtsMasterModel.fromJson(data);
      } else {
        throw "Post data ats failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AtsMasterModel> editAtsMaster({
    required int atsId,
    required int popId,
    required String status,
    required String sn,
    required String merk,
    required String tipe,
  }) async {
    late Uri url = UrlService().api('edit-ats');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': atsId,
      'pop_id': popId,
      'status': status,
      'sn': sn,
      'merk': merk,
      'tipe': tipe,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return AtsMasterModel.fromJson(data);
    } else {
      throw "Edit data ats failed";
    }
  }
}
