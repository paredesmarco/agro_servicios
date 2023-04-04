import 'dart:convert';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:logger/logger.dart';

class ProductosImportadosProvider extends BaseProvider {
  Future<List<SolicitudProductosImportadosModelo>> obtenerProductosImportados(
      String identificador,
      String tipoCertificado,
      Future<String?> tokens) async {
    Response res;

    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsProductosImportados/productosImportados',
      token: token,
      parametros: '$identificador/$tipoCertificado',
    ).timeout(const Duration(seconds: 30));

    var lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo']['productos_importados'] ?? [];

    List<SolicitudProductosImportadosModelo> listaProductos = [];

    if (listaCuerpo != null) {
      listaProductos = listaCuerpo
          .map((model) => SolicitudProductosImportadosModelo.fromJson(model))
          .toList();
    }
    return listaProductos;
  }

  Future sincronizarUp(
      Map<String, dynamic> verificacionSalida, Future<String?> token) async {
    final log = Logger();
    final tokenEnvio = await token;
    final Response res = await httpPostWS(
      endPoint: 'RestWsProductosImportados/inspeccionPoductosImportados',
      parametrosJson: jsonEncode(verificacionSalida),
      token: tokenEnvio,
    ).timeout(const Duration(seconds: 30));
    // print(res.body);
    log.d(res.body);
    return res;
  }
}
