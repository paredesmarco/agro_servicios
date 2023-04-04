import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/repository/trampeo_mf_sv_repository.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';

class TrampeoMfSvLaboratorioController extends GetxController {
  final _repository = Get.find<TrampeoMfSvRepository>();
  final ctrTrampeoController = Get.find<TrampeoMfSvController>();
  var codigoTrampa = 'Este es el codigo de campo de la muestra'.obs;

  final TrampasMfSvLaboratorioModelo ordenLaboratorio =
      TrampasMfSvLaboratorioModelo();

  final List<TrampasMfSvDetalleModelo> lista = [];
  int _numeroSecuencial = 0;
  int numeroSecuencial = 0;

  String? errorCodigoTrampa;
  String? errorTipoMuestra;

  var entomologico = false.obs;
  var codigoMuestra = ''.obs;
  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var validandoBajada = true.obs;

  @override
  void onReady() {
    getrampaDetalle();
    super.onReady();
  }

  List<TrampasMfSvDetalleModelo> get trampaDetalle =>
      Get.find<TrampeoMfSvController>().listaTrampasDetalle;

  set setCodigoMuestra(valor) => ordenLaboratorio.codigoMuestra = valor;
  set setTipoMuestra(valor) => ordenLaboratorio.tipoMuestra = valor;
  set setAnalisis(valor) => ordenLaboratorio.analisis = valor;
  set setCodigoTrampaPadre(valor) => ordenLaboratorio.codigoTrampaPadre = valor;

  void getrampaDetalle() {
    final List<TrampasMfSvDetalleModelo> listaOrden =
        Get.find<TrampeoMfSvController>().listaTrampasDetalle;
    for (var e in listaOrden) {
      if (e.envioMuestra == 'Si') {
        lista.add(e);
      }
    }
    update(['idCodigo']);
  }

  Future<void> generarCodigoMuestra(String? codigoTrampa) async {
    List numeroTrampas;

    List<TrampasMfSvLaboratorioModelo> listaLaboratorio = ctrTrampeoController
        .listaOrdenesLaboratorio
        .where((e) => e.codigoTrampaPadre!.contains(codigoTrampa!))
        .toList();

    if (listaLaboratorio.isNotEmpty) {
      _numeroSecuencial = listaLaboratorio.last.secuencial! + 1;
    } else {
      numeroTrampas = await _repository.getSecuencialOrden(codigoTrampa!);
      _numeroSecuencial = numeroTrampas[0]['secuencial_orden'] + 1;
    }

    String secuencia = _numeroSecuencial.toString().padLeft(5, "0");

    codigoMuestra.value = 'MMF-$secuencia';
    ordenLaboratorio.codigoMuestra = codigoMuestra.value;
    ordenLaboratorio.secuencial = _numeroSecuencial;
  }

  set setEntomologico(bool valor) {
    entomologico.value = valor;
    if (valor) {
      ordenLaboratorio.analisis = 'Entomológico';
    } else {
      ordenLaboratorio.analisis = '';
    }
    update();
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  bool validarFormulario() {
    bool esValido = true;
    if (ordenLaboratorio.codigoTrampaPadre == '' ||
        ordenLaboratorio.codigoTrampaPadre == null) {
      errorCodigoTrampa = 'Campo Obligatorio';
      esValido = false;
    } else {
      errorCodigoTrampa = null;
    }

    if (ordenLaboratorio.tipoMuestra == '' ||
        ordenLaboratorio.tipoMuestra == null) {
      errorTipoMuestra = 'Campo Obligatorio';
      esValido = false;
    } else {
      errorCodigoTrampa = null;
    }

    update(['idCodigo', 'idValidacion']);

    return esValido;
  }

  Future<void> guardarFormulario({
    required String titulo,
    required Widget mensaje,
    required Widget icono,
  }) async {
    iniciarValidacion(mensaje: 'Almacenando...');

    Get.bottomSheet(Modal(titulo: titulo, mensaje: mensaje, icono: icono),
        shape: Modal.borde(),
        isDismissible: false,
        isScrollControlled: false,
        enableDrag: false);

    await Future.delayed(const Duration(seconds: 1));

    ordenLaboratorio.idTablet = Random().nextInt(100);

    Get.find<TrampeoMfSvController>()
        .listaOrdenesLaboratorio
        .add(ordenLaboratorio);

    finalizarValidacion('Registros almacenados');

    Get.find<TrampeoMfSvController>().cantidadOrdenes++;

    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}
