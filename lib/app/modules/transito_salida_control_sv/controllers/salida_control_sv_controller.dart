import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/verificacion_transito_salida_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_salida_control_sv_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';

class SalidaControlSvController extends GetxController
    with GetTickerProviderStateMixin, ControladorBase {
  RxString mensajeBajarDatos = 'Sincronizando...'.obs;
  RxString mensajeSubirDatos = 'Sincronizando...'.obs;

  RxBool validandoBajada = true.obs;
  RxBool validandoSubida = true.obs;

  String estadoBajada = '';
  String mensajeRespuesta = '';

  final _repositorio = Get.find<TransitoSalidaControlSvRepository>();

  RxInt cantidadSalida = 0.obs;

  @override
  void onInit() {
    obtenerCantidadRegistrosVerificacionSalida();
    super.onInit();
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  void finalizarValidacionSubida(String mensaje) {
    validandoSubida.value = false;
    mensajeSubirDatos.value = mensaje;
  }

  Future<void> obtenerCantidadRegistrosVerificacionSalida() async {
    var res = await _repositorio.getCantidadRegistrosRealizados();
    cantidadSalida.value = res[0]['cantidad'];
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistrosVerificacionSalida();
    if (cantidadSalida <= 0) {
      await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
    } else {
      mensajeBajarDatos.value = REGISTROS_PENDIENTES;

      estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
        titulo: SINCRONIZACION_PENDIENTES,
        mensaje: mensaje,
        icono: icono,
        mostrarBotones: true,
        alto: 280,
        bajarDatos: () async {
          Get.back();
          await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
        },
      );
    }
  }

  Future<void> _bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    int tiempo = 3;

    iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));

    ProvinciaUsuarioContratoModelo? provincia =
        await _repositorio.getProvinciaContrato();

    final usuario = await _repositorio.getsusuario();

    final RespuestaProvider resProvincia = await ejecutarConsulta(() async {
      return await _repositorio.getUbicacionContrato(usuario!.identificador!);
    });

    if (resProvincia.estado == 'exito') {
      provincia = resProvincia.cuerpo;
      if (provincia?.provincia != null) {
        //Actualizar provincia contrato
        await _repositorio.eliminarProvinciaContrato();
        await _repositorio.guardarProvinciaContrato(provincia!);

        // Sincronizando Registros desde el Sistema GUIA
        RespuestaProvider res = await ejecutarConsulta(() async {
          return await _repositorio.getRegistrosIngreso(provincia?.provincia);
        });

        if (res.estado == 'exito') {
          mensajeRespuesta =
              'Se sincronizaron los registros de verificaciones de tránsito de ingreso';
          final List<RegistrosTransitoIngresoModelo> registros = res.cuerpo;
          if (registros.isNotEmpty) {
            await _repositorio.eliminarRegistrosIngresoProductosSincronizados();
            await _repositorio.eliminarRegistrosIngresoSincronizados();

            for (var e in registros) {
              await _repositorio.guardarRegistrosIngreso(e);
              e.formularioingresotransitoproductolist?.forEach((e) async {
                await _repositorio.guardarRegistrosIngresoProducto(e);
              });
            }
            estadoBajada = 'exito';
          } else {
            estadoBajada = 'error';
            mensajeRespuesta =
                'No existen datos para sincronizar, o existe un problema con su contrato';
          }
        } else {
          estadoBajada = 'error';
          mensajeRespuesta = res.mensaje!;
        }
      } else {
        estadoBajada = 'error';
        mensajeRespuesta = SIN_PROVINCIA_CONTRANTO;
      }
    } else {
      estadoBajada = 'error';
      mensajeRespuesta = resProvincia.mensaje ?? 'Error inesparado';
    }

    /* if (provincia?.provincia != null) {
      RespuestaProvider res = await ejecutarConsulta(() async {
        return await _repositorio.getRegistrosIngreso(provincia?.provincia);
      });

      if (res.estado == 'exito') {
        mensajeRespuesta =
            'Se sincronizaron los registros de verificaciones de tránsito de ingreso';
        final List<RegistrosTransitoIngresoModelo> registros = res.cuerpo;
        if (registros.length > 0) {
          await _repositorio.eliminarRegistrosIngresoProductosSincronizados();
          await _repositorio.eliminarRegistrosIngresoSincronizados();

          registros.forEach((e) async {
            await _repositorio.guardarRegistrosIngreso(e);
            e.formularioingresotransitoproductolist?.forEach((e) async {
              await _repositorio.guardarRegistrosIngresoProducto(e);
            });
          });
          estadoBajada = 'exito';
        } else {
          mensajeRespuesta = 'No existen datos para sincronizar';
        }
      } else {
        estadoBajada = 'error';
        mensajeRespuesta = res.mensaje!;
      }
    } else {
      estadoBajada = 'error';
      mensajeRespuesta = SIN_PROVINCIA_CONTRANTO;
    } */

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }

  Future<void> subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    late List<VerificacionTransitoSalidaModelo> listaVerificacionSalida;
    bool error = false;

    int tiempo = 3;

    Map<String, dynamic> datosPost = {
      "salida": [],
    };

    if (cantidadSalida.value > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaVerificacionSalida =
            await _repositorio.getRegistrosVerificacionSalida();

        final usuario = await _repositorio.getUsuario();

        if (listaVerificacionSalida.isNotEmpty) {
          for (var e in listaVerificacionSalida) {
            e.baseVersion = SCHEMA_VERSION;
            e.tabletId = usuario?.identificador;
          }
          datosPost["salida"] = listaVerificacionSalida;
        }
      } catch (e) {
        mensajeRespuesta = 'Error al preparar datos: $e';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _repositorio.sincronizarUp(datosPost);
        });

        if (res.estado == 'exito') {
          tiempo = 3;
          await _repositorio.eliminarRegistrosVerificacionSalida();
          await obtenerCantidadRegistrosVerificacionSalida();
        } else {
          estadoBajada = 'error';
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
          estadoBajada = 'error';
        } else {
          mensajeRespuesta = res.mensaje!;
        }
        estadoBajada = res.estado!;
      }

      finalizarValidacion(mensajeRespuesta);
    } else {
      mensajeBajarDatos.value = SIN_REGISTROS;
      tiempo = 4;
      estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
          titulo: SIN_DATOS, mensaje: mensaje, icono: icono);
    }

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }
}
