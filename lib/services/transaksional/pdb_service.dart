// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/pdb_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class PdbService {
  Future<List<PdbNilaiModel>> getPdb({required String token}) async {
    var url = UrlService().api('pdb-nilai');
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
      // print(data);
      List<PdbNilaiModel> pdb = List<PdbNilaiModel>.from(
        data.map((e) => PdbNilaiModel.fromJson(e)),
      );
      return pdb;
    } else {
      throw "Get data pdb failed";
    }
  }

  Future<PdbNilaiModel> postPdb(
      {required int pdbId,
      required int pmId,
      required String aresterWarna,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('pdb-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'pdb_id': pdbId,
      'pm_id': pmId,
      'arester_warna': aresterWarna,
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );
    print(response.request);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PdbNilaiModel.fromJson(data);
    } else {
      throw "Post data pdb failed";
    }
  }

  Future<bool> postFotoPdb(
      {required int pdbNilaiId, required Map<String, String> foto}) async {
    late Uri url = UrlService().api('pdb-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    foto.forEach((key, value) async {
      var body = {
        'pdb_nilai_id': pdbNilaiId,
        'fotoFile': key,
        'description': value
      };
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print(response.request);
      } else {
        throw "Post foto pdb failed";
      }
    });
    return true;
  }
}
