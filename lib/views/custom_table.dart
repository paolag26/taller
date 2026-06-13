import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<DataColumn> columns;

  final List<DataRow> rows;

  const CustomTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffe2e8f0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xfff8fafc)),
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade100),
          ),
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }
}
