import 'dart:convert';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class LocalizacionProvider extends BaseProvider {
  Future<List<LocalizacionCatalogo>> obtenerCatalogoLocalizacion(
      int? localizacion, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsLocalizacion/catalogoLocalizacionProvincia',
      parametros: localizacion != null ? '$localizacion' : '',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo =
        lista['cuerpo'] != null ? lista['cuerpo']['localizacioncatalogo'] : [];

    List<LocalizacionCatalogo> listaLocalizacion = [];

    if (listaCuerpo != null) {
      listaLocalizacion = listaCuerpo
          .map((model) => LocalizacionCatalogo.fromJson(model))
          .toList();
    }
    return listaLocalizacion;
  }

  Future<List<LocalizacionCatalogo>> obtenerLocalizacionPorcategoria(
      int localizacion, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsLocalizacion/localizacionCategoria',
      parametros: '$localizacion',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo =
        lista['cuerpo'] != null ? lista['cuerpo']['localizacioncatalogo'] : [];

    List<LocalizacionCatalogo> listaLocalizacion = [];

    if (listaCuerpo != null) {
      listaLocalizacion = listaCuerpo
          .map((model) => LocalizacionCatalogo.fromJson(model))
          .toList();
    }
    return listaLocalizacion;
  }
}
