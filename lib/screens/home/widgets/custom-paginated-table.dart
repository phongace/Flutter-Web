import 'package:flutter/material.dart';
import 'package:time_store/config/constant.dart';

class CustomPaginatedTale extends StatelessWidget {
  // const CustomPaginatedTale({
  //   Key key,
  //   this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
  //   DataTableSource source,
  //   List<DataColumn> dataColumns,
  //   Widget header,
  //   bool showAction = false,
  //   List<Widget> actions,
  //   this.sortColumnIndex,
  //   this.sortColumnAsc = true,
  //   this.onRowChanged,
  // })  : _source = source,
  //       _dataColumns = dataColumns,
  //       _header = header,
  //       _showAction = showAction,
  //       _actions = actions,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTale();
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
