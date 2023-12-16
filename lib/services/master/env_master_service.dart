// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class EnvironmentMasterService {
  Future<List<EnvironmentMasterModel>> getByPmAndPop(
      {required int pmId, required int popId}) async {
    var url = UrlService().api('environment?pm_id=$pmId&pop_id=$popId');
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
      List<EnvironmentMasterModel> env = List<EnvironmentMasterModel>.from(
        data.map((e) => EnvironmentMasterModel.fromJson(e)),
      );
      return env;
    } else {
      throw "Get data failed";
    }
  }

  Future<EnvironmentMasterModel> postEnvMaster(
      {required int popId,
      required int pmId,
      required String exhaust,
      required String lampu,
      required String jumlahLampu,
      required String kebersihanBangunan,
      required String bangunan,
      required double suhuRuangan,
      required String kebersihanExhaust,
      String? temuan,
      String? rekomendasi,
      String? tglInstalasi}) async {
    late Uri url = UrlService().api('environment');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'pm_id': pmId,
      'exhaust': exhaust,
      'kebersihan_exhaust': kebersihanExhaust,
      'lampu': lampu,
      'jumlah_lampu': jumlahLampu,
      'suhu_ruangan': suhuRuangan,
      'bangunan': bangunan,
      'kebersihan_bangunan': kebersihanBangunan,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      'temuan': temuan,
      'rekomendasi': rekomendasi,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return EnvironmentMasterModel.fromJson(data);
    } else {
      throw "Post data env failed";
    }
  }

  Future<bool> deleteMaster({required int id}) async {
    late Uri url = UrlService().api('delete-environment');

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
        throw "Delete data environment failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<EnvironmentMasterModel> editEnvMaster(
      {required int envId,
      required int popId,
      required int pmId,
      required String exhaust,
      required String lampu,
      required String jumlahLampu,
      required String kebersihanBangunan,
      required String bangunan,
      required String suhuRuangan,
      required String kebersihanExhaust,
      String? temuan,
      String? rekomendasi,
      String? tglInstalasi}) async {
    late Uri url = UrlService().api('edit-environment');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': envId,
      'pop_id': popId,
      'pm_id': pmId,
      'exhaust': exhaust,
      'kebersihan_exhaust': kebersihanExhaust,
      'lampu': lampu,
      'jumlah_lampu': jumlahLampu,
      'suhu_ruangan': suhuRuangan,
      'bangunan': bangunan,
      'kebersihan_bangunan': kebersihanBangunan,
      'temuan': temuan,
      'rekomendasi': rekomendasi,
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
      return EnvironmentMasterModel.fromJson(data);
    } else {
      throw "Edit data env failed";
    }
  }

  Future<bool> postFotoEnv(
      {required int envId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('environment-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['env_id'] = envId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto env failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-environment-foto');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'id': imageId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw "Delete image failed";
    }
  }
}
