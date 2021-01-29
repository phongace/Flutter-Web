import 'package:flutter/material.dart';
import 'package:time_store/models/data-table/data.dart';

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    @required List<Data> userData,
    @required this.onRowSelect,
  })  : _userData = userData,
        assert(userData != null);

  final List<Data> _userData;
  final Function(int index) onRowSelect;

  @override
  DataRow getRow(int index) {
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index, // Don't miss
      cells: <DataCell>[
        DataCell(Text('${_user.id}')),
        DataCell(Text('${_user.name}')),
        DataCell(Text('${_user.email}')),
        DataCell(Text('${_user.phone}')),
        DataCell(Text('${_user.website}')),
        DataCell(
          IconButton(
            icon: const Icon(Icons.details),
            onPressed: () => onRowSelect(index),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Data d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
