import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';

class CaracterizacionFrMfSvProvider extends BaseProvider {
  Future<List<LocalizacionModelo?>> obtenerTodasProvincia() async {
    final List<LocalizacionModelo?> lista =
        await DBLocalizcion.db.getTodosProvincias(1);
    return lista;
  }

  Future<List<LocalizacionCatalogo>> obtenerCatalogoLocalizacion(
      int localizacion, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsLocalizacion/catalogoLocalizacionProvincia',
      parametros: '$localizacion',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['localizacioncatalogo'] ?? [];

    List<LocalizacionCatalogo> listaLocalizacion = [
      LocalizacionCatalogo(cantonlist: [LocalizacionCatalogo(nombre: 'prueba')])
    ];

    if (listaCuerpo != null) {
      listaLocalizacion = listaCuerpo
          .map((model) => LocalizacionCatalogo.fromJson(model))
          .toList();
    }

    return listaLocalizacion;
  }

  Future sincronizarUp(
      Map<String, dynamic> caracterizacion, Future<String?> tokens) async {
    final log = Logger();

    final token = await tokens;

    final Response res = await httpPostWS(
      endPoint: 'RestWsMoscaCaracterizacion/guardarCaracterizacion',
      parametrosJson: jsonEncode(caracterizacion),
      token: token,
    ).timeout(const Duration(seconds: 30));
    log.d(res.body);
    return res;
  }
}
