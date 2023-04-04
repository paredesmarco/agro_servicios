import 'dart:convert';
import 'package:agro_servicios/app/data/models/catalogos/productos_transito_modelo.dart';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/catalogos/paises_origen_procedencia_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class RequisitosProvider extends BaseProvider {
  Future<List<PaisesOrigenProcedenciaModelo>>
      obtenerCatalogoPaisOrigenProcedenciaTransito(
          String categoria, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsRquisitos/paisOrigenProcendenciaTransito',
      parametros: categoria,
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    List<PaisesOrigenProcedenciaModelo> listaPaises = [];

    if (listaCuerpo != null) {
      listaPaises = listaCuerpo
          .map((model) => PaisesOrigenProcedenciaModelo.fromJson(model))
          .toList();
    }
    return listaPaises;
  }

  Future<List<ProductosTransitoModelo>> obtenerProductosTransito(
      String categoria, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsRquisitos/productosTransito',
      parametros: categoria,
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    List<ProductosTransitoModelo> listaPaises = [];

    if (listaCuerpo != null) {
      listaPaises = listaCuerpo
          .map((model) => ProductosTransitoModelo.fromJson(model))
          .toList();
    }
    return listaPaises;
  }
}
