import 'package:flutter/material.dart';

class StatisticsTable extends StatelessWidget {
  final List<Map<String, String>> data;
  final String title;

  const StatisticsTable({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(label: Text('Value')),
                DataColumn(label: Text('Time')),
              ],
              rows: List<DataRow>.generate(
                data.length,
                (index) {
                  final item = data[index];
                  return DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(item['value']!)),
                      DataCell(Text(item['time']!)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
