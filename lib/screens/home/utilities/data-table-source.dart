import 'package:flutter/material.dart';
import 'package:time_store/models/data-table/data.dart';

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({@required List<Data> userData})
      : _userData = userData,
        assert(userData != null);

  final List<Data> _userData;

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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;
}
