import 'package:get/get.dart';
import 'dart:math';
import 'dart:developer' as log;

import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_lugar_controller.dart';
import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/home_repository.dart';
import 'package:agro_servicios/app/data/repository/trampeo_mf_sv_repository.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/utils/utils.dart' as utils;

class TrampeoMfSvTrampasController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    obtenerTrampas();
  }

  final controlador = Get.find<TrampeoMfSvLugarController>();
  int? _indexTrampaSeleccionada;
  List<TrampasMfSvModelo> trampas = [];

  final TrampeoMfSvRepository _trampeoRepository =
      Get.find<TrampeoMfSvRepository>();

  set setIndexTrampaSeleccionadas(index) => _indexTrampaSeleccionada = index;

  get indexTrampaSeleccionadas => _indexTrampaSeleccionada;

  Future<void> obtenerTrampas() async {
    if (controlador.esParroquia) {
      trampas = await _trampeoRepository.getTrampasPorParroquia(
        controlador.idCanton,
        controlador.idLugarInstalacion,
        controlador.idParroquia,
      );
      update(['listaTrampa']);
    } else {
      trampas = await _trampeoRepository.getTrampasPorNumero(
        controlador.idCanton,
        controlador.idLugarInstalacion,
        controlador.idNumeroInstalacion,
      );
      update(['listaTrampa']);
    }
  }

  int obtenerIndexTrampa(codigoTrampa) {
    int valor = 0;

    trampas.asMap().forEach((i, value) {
      if (value.codigoTrampa == codigoTrampa) {
        valor = i;
      }
    });

    return valor;
  }

  actualizarCompletados(int index) {
    List<TrampasMfSvModelo> trampasAux = trampas;
    trampasAux.elementAt(index).actualizado = true;
    trampasAux.elementAt(index).llenado = true;
    trampas = trampasAux;
    update(['listaTrampa']);
  }

  bool estaLLenado = false;

  int verificarTrampaLlenada(int index) {
    TrampasMfSvModelo? trampa = trampas[index];
    Get.find<TrampeoMfSvController>().listaTrampasDetalle.asMap().forEach(
      (i, value) {
        if (value.codigoTrampa == trampa.codigoTrampa!) {
          index = i;
          estaLLenado = true;
        }
      },
    );

    return index;
  }

  inactivarTrampa(int index) async {
    TrampasMfSvDetalleModelo trampoDetalle = TrampasMfSvDetalleModelo();
    TrampasMfSvModelo? trampa = trampas[index];

    final homeRepositorio = Get.find<HomeRepository>();

    int? indexDetalleTrampa;

    Random random = Random();

    Get.find<TrampeoMfSvController>().listaTrampasDetalle.asMap().forEach(
      (i, value) {
        if (value.codigoTrampa == trampa.codigoTrampa!) {
          indexDetalleTrampa = i;
          estaLLenado = true;
        }
      },
    );

    if (indexDetalleTrampa == null) {
      log.log('se inactivó y se agregó el detalle');

      UsuarioModelo? usuario = await homeRepositorio.getUsuario();
      trampoDetalle.idProvincia = trampa.idProvincia;
      trampoDetalle.nombreProvincia = trampa.provincia;
      trampoDetalle.idCanton = trampa.idCanton;
      trampoDetalle.nombreCanton = trampa.canton;
      trampoDetalle.idParroquia = trampa.idParroquia;
      trampoDetalle.nombreParroquia = trampa.parroquia;
      trampoDetalle.idLugarInstalacion = trampa.idLugarInstalacion;
      trampoDetalle.nombreLugarInstalacion = trampa.nombreLugarInstalacion;
      trampoDetalle.numeroLugarInstalacion = trampa.numeroLugarInstalacion;
      trampoDetalle.idTipoAtrayente = trampa.idTipoAtrayente;
      trampoDetalle.nombreTipoAtrayente = trampa.nombreTipoAtrayente;
      trampoDetalle.tipoTrampa = trampa.nombreTipoTrampa;
      trampoDetalle.codigoTrampa = trampa.codigoTrampa;
      trampoDetalle.semana = int.parse(utils.semanaDelAnio());
      trampoDetalle.coordenadaX = trampa.coordenadax;
      trampoDetalle.coordenadaY = trampa.coordenaday;
      trampoDetalle.coordenadaZ = trampa.coordenadaz;
      trampoDetalle.fechaInstalacion =
          utils.fechaFormateada('yyyy-MM-dd', trampa.fechaInstalacion!);
      trampoDetalle.estadoTrampa = trampa.estadoTrampa;
      trampoDetalle.exposicion =
          utils.calcularDiasEntreFechas(trampa.fechaInspeccion);
      trampoDetalle.estadoRegistro = 'COMPLETO';
      trampoDetalle.fechaInspeccion = DateTime.now().toString();
      trampoDetalle.usuarioId = usuario!.identificador;
      trampoDetalle.idTablet = (random.nextInt(90) + 1);
      trampoDetalle.usuario = usuario.nombre;
      trampoDetalle.tabletVersionBase = SCHEMA_VERSION;
      trampoDetalle.tabletId = usuario.identificador;
      trampoDetalle.estadoTrampa = 'inactivo';

      Get.find<TrampeoMfSvController>().addTrampaDetalle(trampoDetalle);
    } else {
      Get.find<TrampeoMfSvController>()
          .listaTrampasDetalle[indexDetalleTrampa!]
          .estadoTrampa = 'inactivo';
    }

    trampas[index].estadoTrampa = 'inactivo';
    trampas[index].activo = false;

    update(['listaTrampa']);
  }

  void activarTrampa(int index) {
    trampas[index].estadoTrampa = 'activo';
    trampas[index].activo = true;
    Map trampaBusqueda = validarTrampaLlenada(index);

    if (trampaBusqueda['llenado']) {
      Get.find<TrampeoMfSvController>()
          .listaTrampasDetalle[trampaBusqueda['index']]
          .estadoTrampa = 'inactivo';
    } else {
      Get.find<TrampeoMfSvController>()
          .listaTrampasDetalle
          .removeAt(trampaBusqueda['index']);
    }
    update(['listaTrampa']);
  }

  Map<String, dynamic> validarTrampaLlenada(int index) {
    TrampasMfSvModelo? trampa = trampas[index];
    bool estaLLenado = false;
    int? indexDetalleTrampa;

    Get.find<TrampeoMfSvController>().listaTrampasDetalle.asMap().forEach(
      (i, value) {
        if (value.codigoTrampa == trampa.codigoTrampa!) {
          indexDetalleTrampa = i;
          if (trampa.llenado) {
            estaLLenado = true;
          }
        }
      },
    );

    return {'index': indexDetalleTrampa, 'llenado': estaLLenado};
  }
}
