import 'package:flutter/cupertino.dart';
import 'package:time_store/models/data-table/data.dart';
import 'package:time_store/services/data-service.dart';

class DataTableProvider extends ChangeNotifier {
  List<Data> get datas => _data ?? [];
  List<Data> _data;

  Future<void> fetchData() async {
    try {
      List<Data> list = await DataService.fetchData();
      _data = list;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
