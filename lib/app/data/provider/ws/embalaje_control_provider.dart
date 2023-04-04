import 'dart:convert';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class EmbalajeControlProvider extends BaseProvider {
  Future sincronizarUp(
      Map<String, dynamic> embalaje, Future<String?> tokens) async {
    final token = await tokens;

    final Response res = await httpPostWS(
      endPoint: 'RestWsEmbalaje/embalajeMadera',
      parametrosJson: jsonEncode(embalaje),
      token: token,
    ).timeout(const Duration(seconds: 30));

    return res;
  }
}
