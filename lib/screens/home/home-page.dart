import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/models/data-table/data.dart';
import 'package:time_store/providers/data-table-provider.dart';
import 'package:time_store/screens/home/utilities/data-table-source.dart';
import 'package:time_store/screens/home/widgets/custom-paginated-table.dart';
import 'package:time_store/widgets/navigation-bar.dart';
import 'package:time_store/widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<DataTableProvider>(context);
    final _model = _provider.datas;

    if (_model.isEmpty) {
      _provider.fetchData();
    }

    final _dtSource = UserDataTableSource(
      userData: _model,
      onRowSelect: (index) => _showDetails(
        context,
        _model[index],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Row(
        children: [
          NavigationBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Hello World!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: CustomPaginatedTable(
                      actions: <IconButton>[
                        IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            _provider.fetchData();
                            SnackbarBuilder.showSnackBar(context, Constant.refresh, Colors.blue[700]);
                          },
                        )
                      ],
                      header: const Text(Constant.users),
                      showAction: true,
                      dataColumns: _column(_dtSource, _provider),
                      rowsPerPage: _provider.rowsPerPage,
                      source: _dtSource,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortColumnAsc: _provider.sortAscending,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DataColumn> _column(
    UserDataTableSource _src,
    DataTableProvider _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(Constant.colID),
          tooltip: Constant.colID,
          numeric: true,
          onSort: (colIndex, asc) {
            _sort<num>((user) => user.id, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colName),
          tooltip: Constant.colName,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.name, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colEmail),
          tooltip: Constant.colEmail,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.email, colIndex, asc, _src, _provider);
          },
        ),
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

  void _sort<T>(
    Comparable<T> Function(Data user) getField,
    int colIndex,
    bool asc,
    UserDataTableSource _src,
    DataTableProvider _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showDetails(BuildContext c, Data userData) async => await showDialog<bool>(
        context: c,
        builder: (_) => AlertDialog(
          content: Text('${userData.company}'),
        ),
      );
}

// Row _dataTable() {
//   return Row(
//     children: [
//       Spacer(),
//       SingleChildScrollView(
//         child: Consumer<DataTableProvider>(
//           builder: (_, provider, __) {
//             if (provider.datas.isEmpty) {
//               provider.fetchData();
//               return Center(child: Text('dasdsad'));
//             }
//             return DataTable(
//               sortColumnIndex: 0,
//               sortAscending: false,
//               showBottomBorder: true,
//               headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//                 if (states.contains(MaterialState.selected)) return Colors.white;
//                 return Colors.white;
//               }),
//               dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//                 if (states.contains(MaterialState.selected)) return Colors.green[50];
//                 return null;
//               }),
//               columns: _column(),
//               rows: provider.datas
//                   .map((data) => DataRow(
//                         selected: true,
//                         cells: [
//                           DataCell(Text(data.id.toString())),
//                           DataCell(Text(data.name)),
//                           DataCell(Text(data.email)),
//                           DataCell(Text(data.phone)),
//                           DataCell(Text(data.website)),
//                           DataCell(
//                             Text(data.username),
//                             showEditIcon: true,
//                           ),
//                         ],
//                       ))
//                   .toList(),
//             );
//           },
//         ),
//       ),
//       Spacer(),
//     ],
//   );
// }
