// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/nilai/exalarm_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class ExAlarmService {
  Future<List<ExAlarmNilaiModel>> getExAlarm() async {
    var url = UrlService().api('ex-alarm');
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
      List<ExAlarmNilaiModel> exalarm = List<ExAlarmNilaiModel>.from(
        data.map((e) => ExAlarmNilaiModel.fromJson(e)),
      );
      return exalarm;
    } else {
      throw "Get data exalarm failed";
    }
  }

  Future<List<ExAlarmNilaiModel>> getByPmAndPop(
      {required int pmId, required int popId}) async {
    var url = UrlService().api('ex-alarm?pm_id=$pmId&pop_id=$popId');
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
      List<ExAlarmNilaiModel> exalarm = List<ExAlarmNilaiModel>.from(
        data.map((e) => ExAlarmNilaiModel.fromJson(e)),
      );
      return exalarm;
    } else {
      throw "Get data failed";
    }
  }

  Future<ExAlarmNilaiModel> postExAlarm(
      {required int pmId,
      required int plnOff,
      required int popId,
      required String suhu,
      required String ea,
      required String perangkatEa,
      required String pintu,
      required String gensetRunFail,
      required String smokeAndFire,
      String? tglInstalasi,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('ex-alarm');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'pm_id': pmId,
      'pop_id': popId,
      'pln_off': plnOff,
      'suhu': suhu,
      'ea': ea,
      'perangkat_ea': perangkatEa,
      'pintu': pintu,
      'genset_run_fail': gensetRunFail,
      'smokenfire': smokeAndFire,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return ExAlarmNilaiModel.fromJson(data);
    } else {
      throw "Post data exalarm failed";
    }
  }

  Future<ExAlarmNilaiModel> editExAlarm(
      {required int exAlarmId,
      required int pmId,
      required int plnOff,
      required int popId,
      required String suhu,
      required String ea,
      required String perangkatEa,
      required String pintu,
      required String gensetRunFail,
      required String smokeAndFire,
      String? tglInstalasi,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('edit-ex-alarm');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'id': exAlarmId,
      'pm_id': pmId,
      'pop_id': popId,
      'pln_off': plnOff,
      'suhu': suhu,
      'ea': ea,
      'perangkat_ea': perangkatEa,
      'pintu': pintu,
      'genset_run_fail': gensetRunFail,
      'smokenfire': smokeAndFire,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return ExAlarmNilaiModel.fromJson(data);
    } else {
      throw "edit data exalarm failed";
    }
  }

  Future<bool> postFotoexalarm(
      {required int exalarmNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('ex-alarm-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['ex_alarm_id'] = exalarmNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto exalarm failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-ex-alarm-foto');
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
