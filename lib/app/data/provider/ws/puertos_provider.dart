import 'dart:convert';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class PuertosProvider extends BaseProvider {
  Future<List<PuertosCatalogoModelo>> obtenerCatalogoPuertos(
      Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsPuertos/catalogoPuertos',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo']['puertoscatalogo'] ?? [];

    List<PuertosCatalogoModelo> listaPuertos = [];

    if (listaCuerpo != null) {
      listaPuertos = listaCuerpo
          .map((model) => PuertosCatalogoModelo.fromJson(model))
          .toList();
    }
    return listaPuertos;
  }
}
