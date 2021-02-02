import 'package:flutter/material.dart';
import 'package:time_store/models/data-table/comment.dart';

class CommentDataTableSource extends DataTableSource {
  CommentDataTableSource({
    @required List<Comment> commentData,
    @required this.onRowSelect,
  })  : _commentData = commentData,
        assert(commentData != null);

  final List<Comment> _commentData;
  final Function(int index) onRowSelect;

  @override
  DataRow getRow(int index) {
    final _data = _commentData[index];

    return DataRow.byIndex(
      index: index, // Don't miss
      cells: <DataCell>[
        DataCell(Text('${_data.postId}')),
        DataCell(Text('${_data.id}')),
        DataCell(Text('${_data.name}')),
        DataCell(Text('${_data.email}')),
        DataCell(
          Text(
            '${_data.body}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          showEditIcon: true,
          onTap: () => onRowSelect(index),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _commentData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Comment c) getField, bool ascending) {
    _commentData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
