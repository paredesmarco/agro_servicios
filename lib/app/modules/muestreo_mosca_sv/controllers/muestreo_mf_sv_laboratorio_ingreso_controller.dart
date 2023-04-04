import 'package:agro_servicios/app/data/repository/muestreo_mf_sv_repository.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_controller.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MuestreoMfSvLaboratorioIngresoController extends GetxController {
  @override
  void onInit() {
    generarCodigo();
    // fechaOrden = '';
    super.onInit();
  }

  MuestreoMfSvLaboratorioModeo modeloLaboratorio =
      MuestreoMfSvLaboratorioModeo();

  MuestreoMfSvLaboratorioController ctrLaboratorio =
      Get.find<MuestreoMfSvLaboratorioController>();

  final _muestreoRepository = Get.find<MuestreoMfSvRepository>();

  RxString codigoMuestra = ''.obs;
  String? errorEspecie;
  String? errorSitio;
  String? errorFrutos;
  String? errorQuimico;
  String? errorDescripcion;
  String fechaOrden = '';

  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var validandoBajada = true.obs;

  set setEspecie(valor) => modeloLaboratorio.especieVegetal = valor;
  set setSitio(valor) => modeloLaboratorio.sitioMuestreo = valor;
  set setNumeroRecolectado(valor) =>
      modeloLaboratorio.numeroFrutosColectados = valor;
  set setProductoQuimico(valor) =>
      modeloLaboratorio.aplicacionProductoQuimico = valor;
  set setDescripcion(valor) => modeloLaboratorio.descripcionSintomas = valor;

  Future<void> generarCodigo() async {
    final fecha = DateTime.now().toUtc().millisecondsSinceEpoch.toString();

    final res = await _muestreoRepository.getProvinciaContrato();

    if (ctrLaboratorio.fechaOrdenLaboratorio != '') {
      fechaOrden = ctrLaboratorio.fechaOrdenLaboratorio;
    } else {
      fechaOrden = fecha.toString();
    }

    codigoMuestra.value = generarCodigoMuestra(
      provincia: res?.provincia ?? '',
      secuencia: Get.find<MuestreoMfSvController>().modeloLaboratorio.length,
      fechaInicial: fechaOrden,
      codigoFormulario: 'MF',
    );
    modeloLaboratorio.codigoMuestra = codigoMuestra.value;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (modeloLaboratorio.especieVegetal == null ||
        modeloLaboratorio.especieVegetal == '') {
      errorEspecie = 'Campo requerido';
      esValido = false;
    } else {
      errorEspecie = null;
    }

    if (modeloLaboratorio.sitioMuestreo == null ||
        modeloLaboratorio.sitioMuestreo == '') {
      errorSitio = 'Campo requerido';
      esValido = false;
    } else {
      errorSitio = null;
    }

    if (modeloLaboratorio.numeroFrutosColectados == null ||
        modeloLaboratorio.numeroFrutosColectados == '') {
      errorFrutos = 'Campo requerido';
      esValido = false;
    } else {
      errorFrutos = null;
    }

    if (modeloLaboratorio.aplicacionProductoQuimico == null ||
        modeloLaboratorio.aplicacionProductoQuimico == '') {
      errorQuimico = 'Campo requerido';
      esValido = false;
    } else {
      errorQuimico = null;
    }

    if (modeloLaboratorio.descripcionSintomas == null ||
        modeloLaboratorio.descripcionSintomas == '') {
      errorDescripcion = 'Campo requerido';
      esValido = false;
    } else {
      errorDescripcion = null;
    }
    update();
    return esValido;
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  Future<void> guardarFormulario({
    required String titulo,
    required Widget mensaje,
    required Widget icono,
  }) async {
    iniciarValidacion(mensaje: 'Almacenando...');

    int tiempo = 4;
    String mensajeRespuesta = '';

    Get.bottomSheet(Modal(titulo: titulo, mensaje: mensaje, icono: icono),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        isDismissible: false,
        isScrollControlled: false,
        enableDrag: false);

    await Future.delayed(const Duration(seconds: 1));

    try {
      Get.find<MuestreoMfSvController>()
          .modeloLaboratorio
          .add(modeloLaboratorio);
      ctrLaboratorio.cantidadOrdenes += 1;
      ctrLaboratorio.fechaOrdenLaboratorio = fechaOrden;
      mensajeRespuesta = 'Registros almacenados';
      tiempo = 1;
    } catch (e) {
      mensajeRespuesta = 'Error: $e';
      validandoBajada.value = false;
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));
  }
}
