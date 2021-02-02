import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/models/data-table/comment.dart';
import 'package:time_store/providers/comments-provider.dart';
import 'package:time_store/screens/home/utilities/comment-table-source.dart';
import 'package:time_store/screens/home/widgets/custom-paginated-table.dart';
import 'package:time_store/widgets/navigation-bar.dart';
import 'package:time_store/widgets/snackbar.dart';

class TableComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<CommentProvider>(context);
    final _model = _provider.comments;

    if (_model.isEmpty) {
      _provider.fetchData();
    }

    final _dtSource = CommentDataTableSource(
      commentData: _model,
      onRowSelect: (index) => _showDetailBody(
        context,
        _model[index],
      ),
    );

    return Scaffold(
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
                            showSBar(context, Constant.refresh);
                          },
                        )
                      ],
                      header: const Text(Constant.users),
                      showAction: true,
                      dataColumns: _column(_dtSource, _provider),
                      source: _dtSource,
                      rowsPerPage: _provider.rowsPerPage,
                      onRowChanged: (index) => _provider.rowsPerPage = index,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortColumnAsc: _provider.sortAscending,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DataColumn> _column(
    CommentDataTableSource _src,
    CommentProvider _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(Constant.colPostId),
          tooltip: Constant.colPostId,
          numeric: true,
          onSort: (colIndex, asc) {
            _sort<num>((cmt) => cmt.postId, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colID),
          tooltip: Constant.colID,
          numeric: true,
          onSort: (colIndex, asc) {
            _sort<num>((cmt) => cmt.id, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colName),
          tooltip: Constant.colName,
          onSort: (colIndex, asc) {
            _sort<String>((cmt) => cmt.name, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colEmail),
          tooltip: Constant.colEmail,
          onSort: (colIndex, asc) {
            _sort<String>((cmt) => cmt.email, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(Constant.colBody),
          tooltip: Constant.colBody,
          onSort: (colIndex, asc) {
            _sort<String>((cmt) => cmt.body, colIndex, asc, _src, _provider);
          },
        ),
      ];

  void _showDetailBody(BuildContext c, Comment cmt) async => await showDialog<bool>(
        context: c,
        builder: (_) => AlertDialog(
          content: Text('${cmt.body}'),
        ),
      );

  void _sort<T>(
    Comparable<T> Function(Comment cmt) getField,
    int colIndex,
    bool asc,
    CommentDataTableSource _src,
    CommentProvider _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }
}
