import 'package:flutter/cupertino.dart';
import 'package:time_store/models/data-table/data.dart';
import 'package:time_store/services/data-service.dart';

class DataTableProvider extends ChangeNotifier {
  DataTableProvider() {
    fetchData();
  }

  List<Data> _dataTable = [];

  Future<List<Data>> fetchData() async {
    _dataTable = await DataService.fetchData();
    notifyListeners();
  }
}
