import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/providers/data-table-provider.dart';
import 'package:time_store/router/routing-name.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RoutingNameConstant.Login),
            child: Text('DADSD'),
          ),
          const SizedBox(height: 80),
          _dataTable(),
        ],
      ),
    );
  }

  Row _dataTable() {
    return Row(
      children: [
        Spacer(),
        SingleChildScrollView(
          child: Consumer<DataTableProvider>(
            builder: (_, provider, __) {
              if (provider.datas.isEmpty) {
                provider.fetchData();
                return Center(child: Text('dasdsad'));
              }
              return DataTable(
                sortColumnIndex: 0,
                sortAscending: false,
                showBottomBorder: true,
                headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) return Colors.white;
                  return Colors.white;
                }),
                dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) return Colors.green[50];
                  return null;
                }),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(Constant.colID),
                    tooltip: Constant.colID,
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(Constant.colName),
                    tooltip: Constant.colName,
                  ),
                  DataColumn(
                    label: Text(Constant.colEmail),
                    tooltip: Constant.colEmail,
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
                ],
                rows: provider.datas
                    .map((data) => DataRow(
                          selected: true,
                          cells: [
                            DataCell(Text(data.id.toString())),
                            DataCell(Text(data.name)),
                            DataCell(Text(data.email)),
                            DataCell(Text(data.phone)),
                            DataCell(Text(data.website)),
                            DataCell(
                              Text(data.username),
                              showEditIcon: true,
                            ),
                          ],
                        ))
                    .toList(),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
