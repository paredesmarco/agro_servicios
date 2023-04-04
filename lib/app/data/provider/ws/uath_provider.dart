import 'dart:convert';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class UathProvider extends BaseProvider {
  Future<ProvinciaUsuarioContratoModelo> obtenerUbicacionContrato(
      String identificador, Future<String?> tokens) async {
    final token = await tokens;

    final Response res = await httpGettWS(
      endPoint: 'RestWsUath/ubicacionContrato',
      token: token,
      parametros: identificador,
    ).timeout(const Duration(seconds: 30));

    Map<String, dynamic> lista = json.decode(res.body);

    if (lista['estado'] == 'error') throw Exception(lista['mensaje']);
    return ProvinciaUsuarioContratoModelo.fromJson(lista['cuerpo']);
  }
}
