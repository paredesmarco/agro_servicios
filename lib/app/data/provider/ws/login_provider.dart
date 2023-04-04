import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import 'package:agro_servicios/app/data/models/login/ingreo_usuario_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/token/sesion_token_modelo.dart';
import 'package:agro_servicios/app/data/models/token/token_modelo.dart';

class LoginProvider extends BaseProvider {
  ///
  /// Autentica el usuario y si es válido devuelve un [IngresoUsuarioModelo]
  ///
  Future<IngresoUsuarioModelo> login(
      String usuario, String clave, String tipoIngreso,
      {String publicKey = ''}) async {
    Response res;
    IngresoUsuarioModelo usuarioModelo;

    if (publicKey != '') publicKey = '/$publicKey';

    res = await httpGettWS(
      endPoint: 'RestWsLogin/login',
      parametros: '$usuario/$clave/$tipoIngreso$publicKey',
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    usuarioModelo = IngresoUsuarioModelo.fromJson(lista);

    return usuarioModelo;
  }

  ///
  /// Permmite obtener un token desde el servidor enviando una llave pública
  ///
  Future<IngresoUsuarioModelo?> loginToken({String publicKey = ''}) async {
    Response res;
    IngresoUsuarioModelo usuarioModelo;

    if (publicKey != '') publicKey = '/$publicKey';

    Map<String, dynamic> publickey = {'publickey': PUBLIC_KEY};

    res = await httpPostWS(
      endPoint: 'RestWsLogin/login///biometrico',
      parametrosMap: publickey,
      json: false,
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    usuarioModelo = IngresoUsuarioModelo.fromJson(lista);

    return usuarioModelo;
  }

  ///
  ///Guarda el Token en la Session
  ///
  Future<void> guardarSesionToken(TokenModelo token) async {
    final SesionTokenModelo sesion = SesionTokenModelo(
      token: token.token,
      expiraEn: token.expiraEn,
      fechaCreacion: DateTime.now(),
    );

    final data = jsonEncode(sesion.toJson());
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'SESSION', value: data);
  }

  ///
  ///Elimina el Token en la Session
  ///
  Future<void> eliminarSesionToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // await _secureStorage.delete(key: 'SESSION');
    await secureStorage.deleteAll();
  }

  ///
  ///Función para obtener el Token de Session  o refrescar Token
  ///
  Future<String?> obtenerToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final data = await secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = SesionTokenModelo.fromJson(jsonDecode(data));

      final DateTime fechaActual = DateTime.now();
      final DateTime fechaCreacion = session.fechaCreacion!;
      final int expiraEn =
          session.expiraEn! - fechaCreacion.millisecondsSinceEpoch ~/ 1000;
      final int diferenciaFaFc = fechaActual.millisecondsSinceEpoch ~/ 1000 -
          fechaCreacion.millisecondsSinceEpoch ~/ 1000;

      //Si el token aun le falta mas de 120 segundos para caducar utiliza el mismo token

      if ((expiraEn - diferenciaFaFc) > 120) {
        debugPrint(
            "----- NO REFRESH TOKEN -- TIEMPO RESTANTE: ${expiraEn - diferenciaFaFc}-----");
        return session.token;
      }

      //Si el token le falta menos de 120 segundos el token se refresca con uno nuevo

      try {
        IngresoUsuarioModelo? res = await loginToken(publicKey: PUBLIC_KEY);
        if (res?.token?.estado == 'exito') {
          await guardarSesionToken(TokenModelo(
              token: res?.token?.token, expiraEn: res?.token?.expiraEn));
        }
        debugPrint("----- REFRESH TOKEN ------");
        return res?.token?.token;
      } catch (e) {
        debugPrint('$e');
        return null;
      }
    } else {
      return null;
    }
  }
}
