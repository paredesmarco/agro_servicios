import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';

class TrampeoMfSvProvider extends BaseProvider {
  Future<List<LocalizacionModelo?>> obtenerTodasProvincia() async {
    final List<LocalizacionModelo?> lista =
        await DBLocalizcion.db.getTodosProvincias(1);
    return lista;
  }

  Future<List<TrampasMfSvModelo>> obtenerTrampasMosca(
      String localizacion, Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsMoscaTrampa/rutasTrampas',
      parametros: localizacion,
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    List<TrampasMfSvModelo> trampas = [];

    if (listaCuerpo != null) {
      trampas = listaCuerpo
          .map((model) => TrampasMfSvModelo.fromJson(model))
          .toList();
    }

    return trampas;
  }

  Future sincronizarUp(
      Map<String, dynamic> datos, Future<String?> tokens) async {
    final token = await tokens;
    final log = Logger();
    Response res = await httpPostWS(
      endPoint: 'RestWsMoscaTrampa/guardarTrampas',
      parametrosJson: jsonEncode(datos),
      token: token,
    ).timeout(const Duration(seconds: 30));
    log.d(res.body);
    return res;
  }
}
