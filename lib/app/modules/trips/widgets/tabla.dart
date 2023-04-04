import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:flutter/material.dart';

class Tabla extends StatelessWidget {
  final double? ancho;
  final String? texto;
  final Color? backgraund;
  final Color? color;
  final Icon? icono;
  final Function? onPressedd;
  final List<TripsSitioModelo> listData;

  const Tabla(
      {Key? key,
      this.ancho,
      this.texto,
      this.backgraund,
      this.color,
      this.onPressedd,
      required this.listData,
      this.icono})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: DataTable(
        sortAscending: false,
        showBottomBorder: true,
        columnSpacing: 15.0,
        columns: _createColumns(),
        rows: _createRows(),
        dataTextStyle: const TextStyle(fontSize: 12, color: Color(0xFF75808f)),
        headingTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF75808f)),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text("N°"), numeric: true),
      const DataColumn(label: Text("Area")),
      const DataColumn(label: Text("Provincia")),
      const DataColumn(label: Text("Cantón")),
      const DataColumn(label: Text("Parroquia")),
    ];
  }

  List<DataRow> _createRows() {
    int j = 1;
    if (listData.isNotEmpty) {
      return listData
          .map((item) => DataRow(cells: [
                DataCell(Text('${j++}')),
                DataCell(Text('${item.area} - ${item.idArea}')),
                DataCell(Text(item.provincia.toString())),
                DataCell(Text(item.canton.toString())),
                DataCell(Text(item.parroquia.toString())),
              ]))
          .toList();
    } else {
      return listData
          .map((item) => const DataRow(cells: [
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
              ]))
          .toList();
    }
  }
}
