import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:agro_servicios/app/common/comunes.dart';

class BlocBase {
  httpRequestWS({
    String? endPoint,
    String? parametros,
    String? token,
  }) async {
    if (parametros != '') {
      parametros = '/$parametros';
    }

    dynamic url;

    if (AMBIENTE == "DE") {
      url = Uri.http(
          URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint$parametros');
    } else {
      url = Uri.https(
          URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint$parametros');
    }

    log(url.toString());

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final res = await http.get(url, headers: headers);

    return res;
  }

  httpPostWS({String? endPoint, String? parametros, String? token}) async {
    Uri url;

    if (AMBIENTE == 'DE') {
      url = Uri.http(URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint');
    } else {
      url = Uri.https(URL_SERVIDOR, '/$NOMBRE_PROYECTO/$RUTA_MODULO/$endPoint');
    }

    debugPrint(url.toString());

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response res = await http.post(
      url,
      body: parametros,
      headers: headers,
    );
    return res;
  }

  String? removerUltimoCaracter({String? cadena, String? caracter}) {
    String? result = cadena;
    String ultimoCaracter;

    if ((cadena != null) && (cadena.isNotEmpty)) {
      ultimoCaracter = cadena.substring(cadena.length - 1);
      if (ultimoCaracter == caracter) {
        result = cadena.substring(0, cadena.length - 1);
      }
    }

    return result;
  }

  ///Obtener los días transcurridos entre 2 fechas sin calcular horas
  int disTranscurridosDesde(DateTime desde, DateTime hasta) {
    desde = DateTime(desde.year, desde.month, desde.day);
    hasta = DateTime(hasta.year, hasta.month, hasta.day);

    return hasta.difference(desde).inDays;
  }
}
