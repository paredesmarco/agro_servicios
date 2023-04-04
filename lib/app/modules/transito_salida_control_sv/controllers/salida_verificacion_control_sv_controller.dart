import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/verificacion_transito_salida_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_salida_control_sv_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalidaVerificacionControlSvController extends GetxController {
  final _repositorio = Get.find<TransitoSalidaControlSvRepository>();
  IngresoTransitoProducto? productoModelo;
  RegistrosTransitoIngresoModelo? registroModelo;
  VerificacionTransitoSalidaModelo verificacionModelo =
      VerificacionTransitoSalidaModelo();

  late int idPadre;

  RxString mensajeModal = 'Almacenando...'.obs;
  String estadoGuardado = '';

  RxBool validandoGuardado = false.obs;
  RxBool errorVerificacion = false.obs;
  RxBool errorEstado = false.obs;

  RxString verificacion = ''.obs;
  RxString estado = ''.obs;

  @override
  void onInit() {
    registroModelo = Get.arguments;
    obtenerProduto();
    super.onInit();
  }

  Future obtenerProduto() async {
    productoModelo = await _repositorio
        .getRegistrosIngresoProducto(registroModelo!.idIngreso!);
    update();
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeModal.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeModal.value = mensaje;
  }

  bool validarFormulario() {
    bool esValido = true;
    if (verificacion.value == '') {
      errorVerificacion.value = true;
      esValido = false;
    } else {
      errorVerificacion.value = false;
    }

    if (estado.value == '') {
      errorEstado.value = true;
      esValido = false;
    } else {
      errorEstado.value = false;
    }

    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    int tiempo = 4;

    String mensajeValidacion = '';

    iniciarValidacion(mensaje: 'Almacenando...');

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    try {
      final UsuarioModelo? usuario = await _repositorio.getUsuario();
      verificacionModelo.idIngreso = registroModelo!.idIngreso;
      verificacionModelo.estadoPrecinto = estado.value;
      verificacionModelo.tipoVerificacion = estado.value;
      verificacionModelo.usuarioSalida = usuario!.nombre;
      verificacionModelo.usuarioIdSalida = usuario.identificador;
      verificacionModelo.fechaSalida = DateTime.now().toString();
      await _repositorio.guardarVerificacionSalida(verificacionModelo);
      mensajeValidacion = 'Registros almacenados';
      estadoGuardado = 'exito';

      tiempo = 1;
    } catch (e) {
      printError();
      debugPrint(e.toString());
      tiempo = 4;
      mensajeValidacion = 'Error al almacenar los datos';
      estadoGuardado = 'error';
    }

    finalizarValidacion(mensajeValidacion);

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
    Get.back();
  }
}
