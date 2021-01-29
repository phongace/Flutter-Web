import 'package:flutter/material.dart';

class CustomPaginatedTable extends StatelessWidget {
  final List<Widget> actions;
  final int rowsPerPage;
  final Widget header;
  final List<DataColumn> dataColumns;
  final Function(String) onRowChanged;
  final bool showAction;
  final DataTableSource source;
  final int sortColumnIndex;
  final bool sortColumnAsc;

  const CustomPaginatedTable({
    Key key,
    this.actions,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    this.header,
    this.dataColumns,
    this.onRowChanged,
    this.showAction = false,
    this.source,
    this.sortColumnIndex,
    this.sortColumnAsc = true,
  }) : super(key: key);

  Widget get _fetchHeader {
    if (header != null) {
      return header;
    }

    return const Text('Data with 7 rows per page');
  }

  DataTableSource get _fetchDataTableSource {
    if (source != null) {
      return source;
    }
    return _DefaultSource();
  }

  List<DataColumn> get _fetchDataColumns {
    if (dataColumns != null) {
      return dataColumns;
    }
    return _defColumns;
  }

  List<Widget> get _fetchActions {
    if (showAction && actions != null) {
      return actions;
    } else if (!showAction) {
      return null;
    }

    return _defAction;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: PaginatedDataTable(
        actions: _fetchActions,
        header: _fetchHeader,
        columns: _fetchDataColumns,
        rowsPerPage: rowsPerPage,
        source: _fetchDataTableSource,
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortColumnAsc,
      ),
    );
  }
}

class _DefaultSource extends DataTableSource {
  @override
  DataRow getRow(int index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text('row #$index')),
          DataCell(Text('name #$index')),
        ],
      );

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}

final _defColumns = <DataColumn>[
  const DataColumn(label: Text('row')),
  const DataColumn(label: Text('name')),
];

final _defAction = <Widget>[
  IconButton(
    icon: const Icon(Icons.info_outline),
    onPressed: () {},
  ),
];
