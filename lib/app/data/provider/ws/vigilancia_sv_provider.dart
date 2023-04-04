import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/respuesta_servicio.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo_singleton.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/local/db_vigilancia_sv.dart';

class VigilanciaSvProvider extends BaseProvider {
  obtenerCatalogoLocalizacion(localizacion, Future<String?> tokens) async {
    String? mensajeValidacion;
    String estado = '';
    late Response res;

    final token = await tokens;

    try {
      res = await httpGettWS(
        endPoint: 'RestWsLocalizacion/catalogoLocalizacionProvincia',
        parametros: '$localizacion',
        token: token,
      ).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        estado = 'exito';
        mensajeValidacion = 'Se sincronizó el catálogo de la provincia';
      } else {
        var lista = json.decode(res.body);
        estado = 'error';
        mensajeValidacion = lista['mensaje'];
      }
    } on TimeoutException catch (e) {
      estado = 'error';
      mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
      debugPrint('$e');
    } on SocketException catch (e) {
      estado = 'error';
      mensajeValidacion =
          'Error en la Red: Por favor verifica que tengas acceso a internet';
      debugPrint('$e');
    } on HttpException catch (e) {
      debugPrint('Error en la petición del servicio web $e');
      estado = 'error';
      mensajeValidacion = 'Error en la petición del servicio web';
    } on FormatException catch (e) {
      debugPrint('Error en el formato de respuesta $e');
      estado = 'error';
      mensajeValidacion = 'Error en el formato de respuesta';
    } on Exception catch (e) {
      debugPrint('Error $e');
      estado = 'error';
      mensajeValidacion = 'Error $e';
    }

    return RespuestaServicio(
      respuesta: res.body,
      mensaje: mensajeValidacion,
      estado: estado,
    );
  }

  sincronizarUp(Map<String, dynamic> vigilancia) async {
    String estado = 'exito';
    String? mensajeValidacion;
    // ignore: prefer_typing_uninitialized_variables
    var body;

    try {
      final Response res = await httpPostWS(
              endPoint: 'RestWsVigilancia/guardarVigilancia',
              parametrosJson: jsonEncode(vigilancia))
          .timeout(const Duration(seconds: 30));

      final logs = Logger();

      logs.d(res.body);

      log(res.body);

      if (res.runtimeType == Response) {
        body = jsonDecode(res.body);
        if (res.statusCode == 200) {
          estado = 'exito';
          mensajeValidacion = body['mensaje'];
        } else {
          estado = 'error';
          if (body['mensaje'].contains('ERROR:')) {
            var split = body['mensaje'].split("ERROR:");
            mensajeValidacion = 'Error servidor:${split[1]}';
          } else {
            mensajeValidacion = body['mensaje'];
          }
        }
      } else {
        estado = 'exito';
      }
    } on TimeoutException catch (e) {
      debugPrint('$e');
      estado = 'error';
      mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
    } on SocketException catch (e) {
      debugPrint('$e');
      estado = 'error';
      mensajeValidacion =
          'Error en la Red: Por favor verifica que tengas acceso a internet';
    } on HttpException catch (e) {
      debugPrint('Error en la petición del servicio web $e');
      estado = 'error';
      mensajeValidacion = 'Error en la petición del servicio web';
    } on FormatException catch (e) {
      debugPrint('Error en el formato de respuesta $e');
      estado = 'error';
      mensajeValidacion = 'Error en el formato de respuesta';
    } on Exception catch (e) {
      debugPrint('Error $e');
      estado = 'error';
      mensajeValidacion = 'Error $e';
    } catch (e) {
      debugPrint('$e');
      mensajeValidacion =
          e.toString().isEmpty ? 'Error inesperado $e' : e.toString();
    }

    return RespuestaServicio(
      // respuesta: res.body,
      mensaje: mensajeValidacion,
      estado: estado,
    );
  }

//Inserst

  guardarLocalizacionCatalogo(LocalizacionCatalogo localizacion) async {
    await DBLocalizcion.db.guardarLocalizacionCatalogo(localizacion);
  }

  guardarProvinciasinronizada(LocalizacionCatalogo localizacion) async {
    await DBVigilanciaSv().guardarProvinciaSincronizada(localizacion);
  }

  guardarVigilancia(VigilanciaModeloSingleton modelo,
      List<OrdenLaboratorioSvModelo> listaOrdenes) async {
    int id = await DBVigilanciaSv().guardarNuevaVigilancia(modelo);

    if (modelo.envioMuestra == 'Si') {
      for (final orden in listaOrdenes) {
        orden.idVigilancia = id;
      }
      await _guardarordenLaboratorio(listaOrdenes);
    }
  }

  _guardarordenLaboratorio(List<OrdenLaboratorioSvModelo> listaOrdenes) async {
    for (final orden in listaOrdenes) {
      await DBVigilanciaSv().guardarOrdenLaboratorio(orden);
    }
  }

//Selects

  Future<LocalizacionModelo?> obtenerProvinciaSincronizada() async {
    final LocalizacionModelo? res =
        await DBVigilanciaSv().getProvinciaSincronizada();
    return res;
  }

  obtenerCantonesSincronizados(int? provincia) async {
    final List<LocalizacionModelo> lista =
        await DBLocalizcion.db.getLocalizacionPorPadre(provincia);
    return lista;
  }

  obtenerParroquiasSincronizados(int provincia) async {
    final List<LocalizacionModelo> lista =
        await DBLocalizcion.db.getLocalizacionPorPadre(provincia);
    return lista;
  }

  obtenerLocalizacionDatos(int id) async {
    final LocalizacionModelo? localizacion =
        await DBLocalizcion.db.getLocalizacionPorId(id);
    return localizacion;
  }

  obtenerVigilancia() async {
    final List<VigilanciaModelo> lista =
        await (DBVigilanciaSv().getVigilancia());
    return lista;
  }

  obtenerOrdenLaboratorio() async {
    final List<OrdenLaboratorioSvModelo> lista =
        await (DBVigilanciaSv().getOrdenesLaboratorio());
    return lista;
  }

//Deletes
  eliminarProvinciaSincronizada() async {
    await DBVigilanciaSv().eliminarProvinciaSincronizada();
  }

  eliminarMonitoreoVigilancia() async {
    await DBVigilanciaSv().eliminarProvinciaSincronizada();
    await DBVigilanciaSv().eliminarMonitoreoVigilanciaOrdenes();
    await DBVigilanciaSv().eliminarMonitoreoVigilancia();
  }
}
