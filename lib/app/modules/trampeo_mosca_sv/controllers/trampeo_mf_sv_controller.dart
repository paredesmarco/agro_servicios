import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_lugar_controller.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_padre_modelo.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/trampeo_mf_sv_repository.dart';

class TrampeoMfSvController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final TrampeoMfSvRepository _trampeoRepository =
      Get.find<TrampeoMfSvRepository>();

  List<TrampasMfSvDetalleModelo> listaTrampasDetalle = [];
  List<TrampasMfSvLaboratorioModelo> listaOrdenesLaboratorio = [];
  List<LocalizacionModelo> provincia1 = [];
  List<LocalizacionModelo> provincia2 = [];
  List<LocalizacionModelo> listaProvinciasDropDown = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];

  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var validandoBajada = true.obs;
  var cantidadOrdenes = 0.obs;
  var cantidadTrampeo = 0.obs;

  int numeroSecuencial = 0;
  int provinciaBajada1 = 0;
  int provinciaBajada2 = 0;
  int index = 0;

  String mensajeRespuesta = '';
  String estadoBajada = '';
  String estadoSubida = '';

  bool? verFab;

  TabController? tabController;

  @override
  void onInit() {
    obtenerTodasProvincias();
    tabController = TabController(length: 2, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    obtenerCantidadRegistrosTrampeo();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.removeListener(cambioVistaTab);
    tabController?.dispose();
    super.onClose();
  }

  get mensaje => mensajeBajarDatos.value;

  set setProvincia(int provincia) => provinciaBajada1 = provincia;

  set setProvincia2(int provincia) => provinciaBajada2 = provincia;

  addTrampaDetalle(TrampasMfSvDetalleModelo trampa) {
    listaTrampasDetalle.add(trampa);
    debugPrint('detalles modificacos ${listaTrampasDetalle.length}');
  }

  void cambioVistaTab() {
    final aniValue = tabController!.animation!.value;
    if (aniValue >= 0.5) {
      if (index != 1) {
        index = 1;
        verFab = true;
        update(['fab']);
      }
    } else if (aniValue <= 0.5 && index > 0) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  void obtenerTodasProvincias() async {
    provincia1 = await _trampeoRepository.getTodasProvincias();
    listaProvinciasDropDown = await _trampeoRepository.getTodasProvincias();
    update();
  }

  void obtenerProvincia2() async {
    provincia2 = await _trampeoRepository.getTodasProvincias();
    update();
  }

  Future obtenerCantidadRegistrosTrampeo() async {
    var res = await _trampeoRepository.getCantidadTrampas();
    cantidadTrampeo.value = res[0]['cantidad'];
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  void eliminarOrdenLaboratorio(index) {
    listaOrdenesLaboratorio.removeAt(index);

    cantidadOrdenes--;
  }

  void actualizarTrampa(TrampasMfSvDetalleModelo trampa, int index) {
    final log = Logger();
    log.d(listaTrampasDetalle[index]);
    log.d(trampa);

    listaTrampasDetalle[index].condicion = trampa.condicion;
    listaTrampasDetalle[index].cambioTrampa = trampa.cambioTrampa;
    listaTrampasDetalle[index].cambioPlug = trampa.cambioPlug;
    listaTrampasDetalle[index].especiePrincipal = trampa.especiePrincipal;
    listaTrampasDetalle[index].estadoFenologicoPrincipal =
        trampa.estadoFenologicoPrincipal;
    listaTrampasDetalle[index].especieColindante = trampa.especieColindante;
    listaTrampasDetalle[index].estadoFenologicoColindante =
        trampa.estadoFenologicoColindante;
    listaTrampasDetalle[index].numeroEspecimenes = trampa.numeroEspecimenes;
    listaTrampasDetalle[index].observaciones = trampa.observaciones;
    listaTrampasDetalle[index].envioMuestra = trampa.envioMuestra;
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistrosTrampeo();
    if (cantidadTrampeo <= 0) {
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
      );
    }
  }

  Future<void> _bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    int tiempo = 2;

    iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));

    RespuestaProvider res = await ejecutarConsulta(() async {
      return await _trampeoRepository.getTrampas(removerUltimoCaracter(
          cadena: '$provinciaBajada1,$provinciaBajada2,', caracter: ','));
    });

    List<TrampasMfSvModelo>? listaTrampas = res.cuerpo;
    mensajeRespuesta = res.mensaje!;

    if (res.estado != 'error') {
      if (listaTrampas!.isNotEmpty) {
        await _trampeoRepository.limpiarTrampas();
        await _trampeoRepository.eliminarOrdenesLaboratorio();
        await _trampeoRepository.eliminarTrampasDetalle();
        await _trampeoRepository.eliminarTrampasInspeccionPadre();
        await _trampeoRepository.eliminarTrampasSincronizadas();
        await obtenerCantidadRegistrosTrampeo();
        tiempo = 2;
        mensajeRespuesta = 'Se sincronizaron ${listaTrampas.length} trampas';

        for (var e in listaTrampas) {
          await _trampeoRepository.guardarTrampas(e);
        }

        estadoBajada = 'exito';
      } else {
        tiempo = 3;
        mensajeRespuesta =
            'No existen trampas para sincronizar en las provincias seleccionadas';
      }
    }

    finalizarValidacion(mensajeRespuesta);
    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }

  Future<void> sinProvincias(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 4));

    Get.back();
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    DateTime fechaActual = DateTime.now();
    TrampasMfSvPadreModelo inspeccionPadre = TrampasMfSvPadreModelo();

    int tiempo = 4;
    int? idInspeccionPadre;
    String mensajeValidacion = '';
    bool valido = true;

    iniciarValidacion(mensaje: 'Almacenando...');

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    try {
      inspeccionPadre.idTablet = listaTrampasDetalle[0].idTablet ?? 1;
      inspeccionPadre.fechaInspeccion = fechaActual;
      inspeccionPadre.usuarioId = listaTrampasDetalle[0].usuarioId;
      inspeccionPadre.usuario = listaTrampasDetalle[0].usuario;
      inspeccionPadre.tabletId = listaTrampasDetalle[0].tabletId;
      inspeccionPadre.tabletVersionBase =
          listaTrampasDetalle[0].tabletVersionBase;

      if (listaTrampasDetalle.isNotEmpty) {
        debugPrint("Guardando inspeccion padre");
        idInspeccionPadre =
            await _trampeoRepository.guardarTrampasPadre(inspeccionPadre);
      }

      if (listaTrampasDetalle.isNotEmpty) {
        for (var e in listaTrampasDetalle) {
          debugPrint("Guardando detalles de trampa");
          e.idPadre = idInspeccionPadre;
          e.fechaInspeccion = fechaActual.toString();
          await _trampeoRepository.guardarDetalleTrampas(e);
          await _trampeoRepository.updateTrampaCompletada(1, e.codigoTrampa!);
        }
      }

      if (listaOrdenesLaboratorio.isNotEmpty) {
        for (var e in listaOrdenesLaboratorio) {
          debugPrint("Guardando ordenes de laboratorio");
          e.idPadre = idInspeccionPadre;
          await _trampeoRepository.guardarOrdenes(e);
        }
      }
      mensajeValidacion = 'Los registros fueron almacenados';
      tiempo = 2;
      valido = true;
    } catch (e) {
      valido = false;
      mensajeValidacion = 'Error: $e';
      tiempo = 4;
      debugPrint('Hubo un error: $e');
    }

    finalizarValidacion(mensajeValidacion);

    await Future.delayed(Duration(seconds: tiempo));

    if (valido) {
      Get.find<TrampeoMfSvLugarController>().encerarLugarTrampeo();
      Get.back();
      Get.back();
    } else {
      Get.back();
    }
  }

  bool validarFormulario() {
    bool esValido = true;
    if (listaTrampasDetalle.isEmpty) {
      esValido = false;
    }
    return esValido;
  }

  Future<void> subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    bool error = false;
    int tiempo = 4;
    String mensajeRespuesta = '';
    Map<String, dynamic> datosPost = {
      "inspeccion": [],
      "detalle": [],
      "ordenes": [],
    };

    if (cantidadTrampeo > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        List<TrampasMfSvPadreModelo> listaDetallesPadre =
            await _trampeoRepository.getDetalleTrampasPadreTodos();

        List<TrampasMfSvDetalleModelo> listaDetalles =
            await _trampeoRepository.getDetallesTrampasTodos();

        List<TrampasMfSvLaboratorioModelo> listaOrdenes =
            await _trampeoRepository.getOrdenesLaboratorioTodos();

        if (listaDetallesPadre.isNotEmpty) {
          datosPost["inspeccion"] = listaDetallesPadre;
          debugPrint("cabecera detalle preparado");
        }

        if (listaDetalles.isNotEmpty) {
          datosPost["detalle"] = listaDetalles;
          debugPrint("detalle preparado");
        }

        if (listaOrdenes.isNotEmpty) {
          datosPost["ordenes"] = listaOrdenes;
          debugPrint("ordenes preparado");
        } else {
          datosPost["ordenes"] = [];
        }

        tiempo = 2;
        error = false;
      } catch (e) {
        debugPrint('Hubo un error: $e');
        mensajeRespuesta = 'Error: $e';
        error = true;
      }

      if (!error) {
        RespuestaProvider res = await ejecutarConsulta(() {
          return _trampeoRepository.sincronizarUp(datosPost);
        });

        if (res.estado == 'exito') {
          debugPrint('sincronizado con exito');
          await _trampeoRepository.eliminarOrdenesLaboratorio();
          await _trampeoRepository.eliminarTrampasDetalle();
          await _trampeoRepository.eliminarTrampasInspeccionPadre();
          await _trampeoRepository.eliminarTrampasSincronizadas();
          await obtenerCantidadRegistrosTrampeo();

          var res = await _trampeoRepository.getCantidadTrampas();
          cantidadTrampeo.value = res[0]['cantidad'];
          tiempo = 3;
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
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
      obtenerCantidadRegistrosTrampeo();
    }

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }
}
