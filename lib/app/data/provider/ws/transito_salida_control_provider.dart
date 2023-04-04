import 'dart:convert';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class TransitoSalidaControlSvProvider extends BaseProvider {
  Future<List<RegistrosTransitoIngresoModelo>> obtenerRegistrosTransitoIngreso(
      Future<String?> tokens, String? provincia) async {
    Response res;

    final token = await tokens;
    res = await httpGettWS(
      endPoint: 'RestWsTransitoSalida/registrosIngreso',
      parametros: provincia ?? '',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo']['ingresos'] ?? [];

    List<RegistrosTransitoIngresoModelo> listaEnvases = [];

    if (listaCuerpo != null) {
      listaEnvases = listaCuerpo
          .map((model) => RegistrosTransitoIngresoModelo.fromJson(model))
          .toList();
    }
    return listaEnvases;
  }

  Future sincronizarUp(
      Map<String, dynamic> verificacionSalida, Future<String?> token) async {
    final tokenEnvio = await token;
    final Response res = await httpPostWS(
      endPoint: 'RestWsTransitoSalida/salida',
      parametrosJson: jsonEncode(verificacionSalida),
      token: tokenEnvio,
    ).timeout(const Duration(seconds: 30));
    return res;
  }
}
