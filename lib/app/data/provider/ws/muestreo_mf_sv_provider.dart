import 'dart:convert';

import 'package:http/http.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:logger/logger.dart';

class MuestreoMfSvProvider extends BaseProvider {
  Future sincronizarUp(
      Map<String, dynamic> muestreo, Future<String?> tokens) async {
    final token = await tokens;

    final Response res = await httpPostWS(
      endPoint: 'RestWsMoscaMuestreo/guardarMuestreo',
      parametrosJson: jsonEncode(muestreo),
      token: token,
    ).timeout(const Duration(seconds: 30));
    final log = Logger();
    log.d(res.body);
    return res;
  }
}
