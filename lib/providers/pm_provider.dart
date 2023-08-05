import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/services/pm_service.dart';

class PmProvider extends ChangeNotifier {
  List<PmModel> _listPm = [];
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  List<PmModel> get listPm => _listPm;

  set setListPm(List<PmModel> listPm) {
    _listPm = listPm;
    notifyListeners();
  }

  Future<bool> getDataPm({required String token}) async {
    try {
      _listPm = await PmService().getPm(token: token);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
