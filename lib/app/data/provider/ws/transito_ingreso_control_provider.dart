import 'dart:convert';
import 'package:agro_servicios/app/data/models/catalogos/envases_modelo.dart';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:logger/logger.dart';

class TransitoIngresoControlSvProvider extends BaseProvider {
  Future<List<EnvaseModelo>> obtenerCatalogoEnvases(
      String categoria, Future<String?> tokens) async {
    Response res;

    final token = await tokens;
    res = await httpGettWS(
      endPoint: 'RestWsEnvases/tiposEnvases',
      parametros: categoria,
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    List<EnvaseModelo> listaEnvases = [];

    if (listaCuerpo != null) {
      listaEnvases =
          listaCuerpo.map((model) => EnvaseModelo.fromJson(model)).toList();
    }
    return listaEnvases;
  }

  Future sincronizarUp(
      Map<String, dynamic> verificacionIngreso, Future<String?> token) async {
    final tokenEnvio = await token;
    final Response res = await httpPostWS(
      endPoint: 'RestWsTransitoIngreso/ingresos',
      parametrosJson: jsonEncode(verificacionIngreso),
      token: tokenEnvio,
    ).timeout(const Duration(seconds: 30));
    final log = Logger();
    log.d(res.body);
    return res;
  }
}
