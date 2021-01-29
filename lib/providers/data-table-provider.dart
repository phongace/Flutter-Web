import 'package:flutter/material.dart';
import 'package:time_store/models/data-table/data.dart';
import 'package:time_store/services/data-service.dart';

class DataTableProvider extends ChangeNotifier {
  List<Data> get datas => _data ?? [];
  List<Data> _data;

  int _sortColumnIndex;
  bool _sortAscending = true;

  Future<void> fetchData() async {
    try {
      List<Data> list = await DataService.fetchData();
      _data = list;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
