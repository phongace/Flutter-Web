import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/models/data-table/data.dart';
import 'package:time_store/providers/data-table-provider.dart';
import 'package:time_store/screens/home/utilities/data-table-source.dart';
import 'package:time_store/screens/home/widgets/custom-paginated-table.dart';
import 'package:time_store/services/data-service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> _dataTable = [];

  @override
  Widget build(BuildContext context) {
    // final _provider = Provider.of<DataTableProvider>(context);
    // _dataTable = _provider.fetchData() as List<Data>;

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Consumer<DataTableProvider>(
        builder: (context, provider, child) {
          _dataTable = provider.fetchData() as List<Data>;

          return Center(
            child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(Constant.colID),
                    tooltip: Constant.colID,
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
                rows: _dataTable
                    .map((data) => DataRow(
                          cells: [
                            // I want to display a green color icon when user is verified and red when unverified
                            DataCell(Text(data.id.toString())),
                            DataCell(Text(data.name)),
                            DataCell(Text(data.email)),
                            DataCell(Text(data.phone)),
                            DataCell(Text(data.website)),
                            DataCell(Text(data.username)),
                          ],
                        ))
                    .toList()),
          );
        },
      ),
    );
  }
}
