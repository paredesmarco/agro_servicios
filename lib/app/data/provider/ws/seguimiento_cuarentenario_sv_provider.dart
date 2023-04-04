import 'dart:convert';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class SeguimientoCuarentenarioSvProvider extends BaseProvider {
  Future<List<SeguimientoCuarentenarioSolicitudSvModelo>>
      obtenerSeguimientoCuarentnarioSv(Future<String?> tokens) async {
    Response res;

    final token = await tokens;
    res = await httpGettWS(
      endPoint: 'RestWsSeguimientoCuarentenario/solicitudes',
      token: token,
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo']['seguimientos'] ?? [];

    List<SeguimientoCuarentenarioSolicitudSvModelo> listaSeguimientos = [];

    if (listaCuerpo != null) {
      listaSeguimientos = listaCuerpo
          .map((model) =>
              SeguimientoCuarentenarioSolicitudSvModelo.fromJson(model))
          .toList();
    }

    return listaSeguimientos;
  }

  Future sincronizarUp(
      Map<String, dynamic> verificacionSalida, Future<String?> token) async {
    final tokenEnvio = await token;
    final Response res = await httpPostWS(
      endPoint: 'RestWsSeguimientoCuarentenario/seguimientoCuarentenario',
      parametrosJson: jsonEncode(verificacionSalida),
      token: tokenEnvio,
    ).timeout(const Duration(seconds: 30));

    return res;
  }
}
