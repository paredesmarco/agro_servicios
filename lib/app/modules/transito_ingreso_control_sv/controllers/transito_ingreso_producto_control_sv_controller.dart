import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/envases_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/productos_transito_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_producto_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_ingreso_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransitoIngresoProductoControlSvController extends GetxController {
  final _repositorio = Get.find<TransitoIngresoControlSvRepository>();
  final _controlador = Get.find<TransitoIngresoControlSvController>();

  TransitoIngresoProductoSvModelo productoModelo =
      TransitoIngresoProductoSvModelo();

  RxBool validandoGuardado = true.obs;
  RxList<ProductosTransitoModelo> productos = <ProductosTransitoModelo>[].obs;
  RxList<EnvaseModelo> envases = <EnvaseModelo>[].obs;
  RxString mensajeGuardado = ''.obs;
  RxString nombreProducto = ''.obs;

  String? errorPartida;
  String? errorCantidad;
  String? errorEnvase;
  String? estadoGuardado;

  @override
  void onReady() {
    getPartida();
    getEnvase();
    super.onReady();
  }

  set partidaArancelaria(valor) {
    int inicio = valor.indexOf('(');
    int fin = valor.indexOf(')');

    productoModelo.descripcionProducto = valor.substring(0, inicio - 1);
    productoModelo.partidaArancelaria = valor.substring(inicio + 1, fin);
    productoModelo.subtipo = valor.substring(fin + 4);

    nombreProducto.value = productoModelo.descripcionProducto!;
  }

  set cantidad(valor) => productoModelo.cantidad = double.tryParse(valor);

  set tipoEnvase(valor) => productoModelo.tipoEnvase = valor;

  Future<void> getPartida() async {
    final List<ProductosTransitoModelo> res =
        await _repositorio.getProductoTransito();

    productos.value = res;
  }

  Future<void> getEnvase() async {
    final List<EnvaseModelo> res = await _repositorio.getEnvases();

    envases.value = res;
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (productoModelo.partidaArancelaria == null ||
        productoModelo.partidaArancelaria == '') {
      esValido = false;
      errorPartida = CAMPO_REQUERIDO;
    } else {
      errorPartida = null;
    }

    if (!validarDouble(productoModelo.cantidad.toString())) {
      esValido = false;
      errorCantidad = CAMPO_NUMERICO_VALIDO;
    } else {
      errorCantidad = null;
    }

    if (productoModelo.tipoEnvase == null || productoModelo.tipoEnvase == '') {
      esValido = false;
      errorEnvase = CAMPO_REQUERIDO;
    } else {
      errorEnvase = null;
    }

    update(['idValidacion']);
    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarValidacion(mensaje: DEFECTO_A);
    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    _controlador.listaProductoModelo.add(productoModelo);

    await Future.delayed(const Duration(seconds: 1));
    finalizarValidacion(ALMACENADO_EXITO);
    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}
