import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';

class ProductosImportadosLotesController extends GetxController {
  final _controlador = Get.find<ProductosImportadosSvController>();

  String? errorDescripcion;
  String? errorCajasEnvase;
  String? errorPorcentaje;
  String? errorCajasMuestra;

  bool errorAsuenciaSuelo = false;
  bool errorAusenciaContaminante = false;
  bool errorAusenciaSintoma = false;
  bool errorAusenciaPlaga = false;
  bool errorDictamen = false;

  ProductoImportadoLoteModelo lote = ProductoImportadoLoteModelo();

  RxString nroCajasMuestra = ''.obs;

  RxBool validandoGuardado = false.obs;
  RxString mensajeGuardado = DEFECTO_A.obs;
  String estadoGuardado = '';

  get ausenciaSuelo => lote.ausenciaSuelo;
  get ausenciaContaminante => lote.ausenciaContaminantes;
  get ausenciaSintomaPlaga => lote.ausenciaSintomas;
  get ausenciaPlaga => lote.ausenciaPlagas;
  get dictamen => lote.dictamen;

  set descripcionLote(valor) => lote.descripcion = valor;

  set cajasLote(valor) {
    lote.numeroCajas = valor != '' ? int.parse(valor) : null;
    calcularNroCajas();
  }

  set porcentajeInspeccion(valor) {
    lote.porcentajeInspeccion = valor != '' ? valor : null;
    calcularNroCajas();
  }

  set ausenciaSuelo(valor) {
    lote.ausenciaSuelo = valor;
    update(['idAusenciaSuelo']);
  }

  set setAusenciaContaminante(valor) {
    lote.ausenciaContaminantes = valor;
    update(['idAusencuiaContaminante']);
  }

  set setAusenciaSintomaPlaga(valor) {
    lote.ausenciaSintomas = valor;
    update(['idAusencuiaSintomasPlaga']);
  }

  set setAusenciaPlaga(valor) {
    lote.ausenciaPlagas = valor;
    update(['idAusenciaPlaga']);
  }

  set setDictamen(valor) {
    lote.dictamen = valor;
    update(['idDictamen']);
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? DEFECTO_A;
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  void calcularNroCajas() {
    int cajas = lote.numeroCajas ?? 0;

    double porcentaje = double.tryParse(lote.porcentajeInspeccion ?? '0') ?? 0;

    double res = (cajas * porcentaje) / 100;

    lote.cajasMuestra = res.round();

    nroCajasMuestra.value = res.round().toString();
  }

  bool validarFormulario() {
    bool esValido = true;

    if (lote.descripcion == null || lote.descripcion == ''.trim()) {
      esValido = false;
      errorDescripcion = CAMPO_REQUERIDO;
    } else {
      errorDescripcion = null;
    }

    if (lote.numeroCajas == null) {
      esValido = false;
      errorCajasEnvase = CAMPO_REQUERIDO;
    } else {
      errorCajasEnvase = null;
    }

    if (lote.porcentajeInspeccion == null ||
        lote.porcentajeInspeccion == ''.trim()) {
      esValido = false;
      errorPorcentaje = CAMPO_REQUERIDO;
    } else {
      errorPorcentaje = null;
    }

    if (lote.cajasMuestra == null) {
      esValido = false;
      errorCajasMuestra = CAMPO_REQUERIDO;
    } else {
      errorCajasMuestra = null;
    }

    if (lote.ausenciaSuelo == null) {
      esValido = false;
      errorAsuenciaSuelo = true;
    } else {
      errorAsuenciaSuelo = false;
    }

    if (lote.ausenciaContaminantes == null) {
      esValido = false;
      errorAusenciaContaminante = true;
    } else {
      errorAusenciaContaminante = false;
    }

    if (lote.ausenciaSintomas == null) {
      esValido = false;
      errorAusenciaSintoma = true;
    } else {
      errorAusenciaSintoma = false;
    }

    if (lote.ausenciaPlagas == null) {
      esValido = false;
      errorAusenciaPlaga = true;
    } else {
      errorAusenciaPlaga = false;
    }

    if (lote.dictamen == null) {
      esValido = false;
      errorDictamen = true;
    } else {
      errorDictamen = false;
    }

    update([
      'idValidacion',
      'idAusenciaSuelo',
      'idAusencuiaContaminante',
      'idAusencuiaSintomasPlaga',
      'idAusenciaPlaga',
      'idDictamen'
    ]);

    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarValidacion(mensaje: ALMACENANDO);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    _controlador.listaLotes.add(lote);
    // _controlador.cantidadOrdenes.value = _controlador.listaLaboratorio.length;

    finalizarValidacion(ALMACENADO_EXITO);

    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}
