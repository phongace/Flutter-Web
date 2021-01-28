import 'package:flutter/material.dart';
import 'package:time_store/config/constant.dart';

class CustomPaginatedTable extends StatelessWidget {
  final List<Widget> actions;
  final int rowsPerPage;
  final Widget header;
  final List<DataColumn> dataColumns;
  final Function(String) onRowChanged;
  final bool showAction;
  final DataTableSource source;
  final bool sortColumnIndex;
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

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      actions: [],
      dataColumns: _col(),
    );
  }

  List<DataColumn> _col() => <DataColumn>[
        DataColumn(
          label: Text(Constant.colPhone),
          tooltip: Constant.colPhone,
        ),
        DataColumn(
          label: Text(Constant.colWebsite),
          tooltip: Constant.colWebsite,
        ),
        DataColumn(
          label: Text(Constant.otherDetails),
          tooltip: Constant.otherDetails,
        ),
      ];
}
