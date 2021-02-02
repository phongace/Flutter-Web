import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_store/models/data-table/comment.dart';
import 'package:time_store/services/data-service.dart';

class CommentProvider extends ChangeNotifier {
  List<Comment> get comments => _comment ?? [];
  List<Comment> _comment;

  int _sortColumnIndex;
  bool _sortAscending = true;

  Future<void> fetchData() async {
    try {
      List<Comment> list = await DataService.fetchComment();
      _comment = list;
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
