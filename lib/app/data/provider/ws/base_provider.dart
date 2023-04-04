import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:agro_servicios/app/common/comunes.dart';

class BaseProvider {
  /// Realiza una petición GET al servidor
  ///
  /// Para enviar parámetros debe enviar un [String] con los parámetros separados con "/" en la propiedad [parametros]
  ///
  ///[token] este parámetro se ebe enviar el token de sesión para poder consumir los servicios
  httpGettWS({
    required String endPoint,
    String? parametros = '',
    String? token,
  }) async {
    // if (parametros != '') {
    parametros = '/$parametros';
    // }

    Uri url;

    if (AMBIENTE == "DE") {
      url = Uri.http(
          URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint$parametros');
    } else {
      url = Uri.https(
          URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint$parametros');
    }

    debugPrint(url.toString());

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final http.Response res = await http.get(url, headers: headers);

    return res;
  }

  /// Realiza una petición POST al servidor
  ///
  /// La propiedad [json] por defecto indica que se enviarán los parárametros en formato json,
  /// para enviar los parámetros post se debe poner este valor en [false]
  ///
  /// Para enviar los parámetros post debe enviar un [Map<String, dynamic>] en la propiedad [parametrosMap]
  ///
  /// Para enviar los parámetros json debe enviar un [String] del json en la propiedad [parametrosJson]
  httpPostWS({
    required String endPoint,
    String? parametrosJson,
    bool json = true,
    Map? parametrosMap,
    String? token,
  }) async {
    Uri url;
    http.Response res;

    if (AMBIENTE == 'DE') {
      url = Uri.http(URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint');
    } else {
      url = Uri.https(URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint');
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    debugPrint(url.toString());

    if (json) {
      res = await http.post(url, body: parametrosJson, headers: headers);
      return res;
    } else {
      res = await http.post(url, body: parametrosMap);
      return res;
    }
  }
}
