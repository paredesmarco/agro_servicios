import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

import 'package:agro_servicios/app/utils/mensajes_request.dart';
import 'package:agro_servicios/app/utils/respuesta_provider.dart';

export 'package:agro_servicios/app/utils/respuesta_provider.dart';

class ControladorBase {
  Future<RespuestaProvider> ejecutarConsulta(Function funcion) async {
    // ignore: prefer_typing_uninitialized_variables
    var res;
    String mensajeRespuesta = 'Transacción existosa';
    String estado = 'error';
    // ignore: prefer_typing_uninitialized_variables
    var body;

    try {
      res = await funcion();

      if (res.runtimeType == Response) {
        body = jsonDecode(res.body);
        if (res?.statusCode == 200) {
          estado = 'exito';
          mensajeRespuesta = body['mensaje'];
        } else {
          estado = 'error';
          if (body['mensaje'].contains('ERROR:')) {
            var split = body['mensaje'].split("ERROR:");
            mensajeRespuesta = 'Error servidor:${split[1]}';
          } else {
            mensajeRespuesta = body['mensaje'];
          }
        }
      } else {
        estado = 'exito';
      }
    } on DatabaseException catch (e) {
      debugPrint('$e');
      mensajeRespuesta = 'Error bdd: $e';
    } on TimeoutException catch (e) {
      debugPrint('excepción de tiempo de espera: $e');
      mensajeRespuesta = MensajesRequest.timeout;
    } on SocketException catch (e) {
      debugPrint('$e');
      mensajeRespuesta = MensajesRequest.socket;
    } on HttpException catch (e) {
      debugPrint('$e');
      mensajeRespuesta = MensajesRequest.http;
    } on FormatException catch (e) {
      debugPrint('$e');
      mensajeRespuesta = MensajesRequest.format;
    } on Exception catch (e) {
      debugPrint('$e');
      mensajeRespuesta =
          e.toString().isEmpty ? MensajesRequest.exception : e.toString();
    } catch (e) {
      debugPrint('$e');
      mensajeRespuesta =
          e.toString().isEmpty ? MensajesRequest.exception : e.toString();
    }

    return RespuestaProvider(
        mensaje: mensajeRespuesta,
        cuerpo: body?['cuerpo'] ?? res,
        estado: estado);
  }
}
