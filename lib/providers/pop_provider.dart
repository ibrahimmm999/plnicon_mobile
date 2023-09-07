import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pop_model.dart';
import 'package:plnicon_mobile/services/pop_service.dart';

class PopProvider extends ChangeNotifier {
  List<PopModel> _listPop = [];

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  List<PopModel> get listPop => _listPop;

  set setListPop(List<PopModel> listPop) {
    _listPop = listPop;
    notifyListeners();
  }

  Future<bool> getDataPop({required int id}) async {
    try {
      _listPop = await PopService().getPop(id: id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    }
  }
}
