import 'package:agro_servicios/app/data/models/pantalla_informativa/pantallas_modelo.dart';
import 'package:flutter/services.dart' show rootBundle;

export 'package:agro_servicios/app/data/models/pantalla_informativa/pantallas_modelo.dart';

class _InfoInicial {
  List<dynamic> pantallas = [];
  Map<String, List<Pantallas>> pantallasInfo = {};

  Future<List<Pantallas>> cargarDatos() async {
    final resp = await rootBundle.loadString('json/info_inicial.json');

    final pantalla = pantallasFromJson(resp);

    return (pantalla);
  }
}

final pantallas = _InfoInicial();
