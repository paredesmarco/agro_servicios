import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/repository/seguimiento_cuarentenario_sv_repository.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';

class SeguimientoCuarentenarioLaboratorioSvController extends GetxController {
  @override
  void onReady() {
    generarCodigo();
    super.onReady();
  }

  final _seguimientoRepository =
      Get.find<SeguimientoCuarentenarioSvRepository>();
  SeguimientoCuarentenarioLaboratorioSvModelo laboratorioModelo =
      SeguimientoCuarentenarioLaboratorioSvModelo();

  final _controlador = Get.find<SeguimientoCuarentenarioSvController>();

  RxBool esIdentificacionInsectos = false.obs;
  RxBool esExtracion01 = false.obs;
  RxBool esExtracion02 = false.obs;
  RxBool esExtracion03 = false.obs;
  RxBool esExtracion06 = false.obs;
  RxBool esExtracion09 = false.obs;
  RxBool esExtracion12 = false.obs;
  RxBool esExtracion14 = false.obs;
  RxBool esFitopalogicoFp07 = false.obs;
  RxBool esFitopalogicoFp05 = false.obs;
  RxBool esFitopalogicoFp01 = false.obs;
  RxBool esFitopalogicoFp03 = false.obs;
  RxBool esFitopalogicoFp10 = false.obs;
  RxBool esFitopalogicoFp02 = false.obs;
  RxBool esFitopalogicoFp04 = false.obs;
  RxBool esFitopalogicoFp06 = false.obs;
  RxBool esFitopalogicoFp08 = false.obs;
  RxBool esFitopalogicoFp11 = false.obs;
  RxBool esFitopalogicoFp12 = false.obs;
  RxBool validandoGuardado = false.obs;
  RxBool errorAnalisis = false.obs;
  RxString mensajeGuardado = DEFECTO_A.obs;
  RxString codigoMuestra = ''.obs;
  String estadoGuardado = '';

  String _identificacionInsectos = '';
  String _extracion01 = '';
  String _extracion02 = '';
  String _extracion03 = '';
  String _extracion06 = '';
  String _extracion09 = '';
  String _extracion12 = '';
  String _extracion14 = '';
  String _fitopalogicoFp07 = '';
  String _fitopalogicoFp05 = '';
  String _fitopalogicoFp01 = '';
  String _fitopalogicoFp03 = '';
  String _fitopalogicoFp10 = '';
  String _fitopalogicoFp02 = '';
  String _fitopalogicoFp04 = '';
  String _fitopalogicoFp06 = '';
  String _fitopalogicoFp08 = '';
  String _fitopalogicoFp11 = '';
  String _fitopalogicoFp12 = '';

  String? errorTipoMuestra;
  String? errorProductoQuimico;
  String? errorPrediagnostico;
  String? errorDescripcionSintomas;

  set tipoMuestra(valor) => laboratorioModelo.tipoMuestra = valor;

  set productoQuimico(valor) =>
      laboratorioModelo.aplicacionProductoQuimico = valor;

  set prediagnostico(valor) => laboratorioModelo.prediagnostico = valor;

  set descripcion(valor) => laboratorioModelo.descripcionSintomas = valor;

  set identificacionInsectos(bool valor) {
    esIdentificacionInsectos.value = valor;
    if (valor) {
      _identificacionInsectos = 'Identificación general de insectos';
    } else {
      _identificacionInsectos = '';
    }
  }

  set extracion01(bool valor) {
    esExtracion01.value = valor;
    if (valor) {
      _extracion01 = ', Extracción de nemátodos (PEE/N/01)';
    } else {
      _extracion01 = '';
    }
  }

  set extracion02(bool valor) {
    esExtracion02.value = valor;
    if (valor) {
      _extracion02 = ', Extracción de nemátodos (PEE/N/02)';
    } else {
      _extracion02 = '';
    }
  }

  set extracion03(bool valor) {
    esExtracion03.value = valor;
    if (valor) {
      _extracion03 = ', Extracción de nemátodos (PEE/N/03)';
    } else {
      _extracion03 = '';
    }
  }

  set extracion06(bool valor) {
    esExtracion06.value = valor;
    if (valor) {
      _extracion06 = ', Extracción de nemátodos (PEE/N/06)';
    } else {
      _extracion06 = '';
    }
  }

  set extracion09(bool valor) {
    esExtracion09.value = valor;
    if (valor) {
      _extracion09 = ', Extracción de nemátodos (PEE/N/12)';
    } else {
      _extracion09 = '';
    }
  }

  set extracion12(bool valor) {
    esExtracion12.value = valor;
    if (valor) {
      _extracion12 = ', Extracción de nemátodos (PEE/N/12)';
    } else {
      _extracion12 = '';
    }
  }

  set extracion14(bool valor) {
    esExtracion14.value = valor;
    if (valor) {
      _extracion14 = ', Extracción de nemátodos (PEE/N/14)';
    } else {
      _extracion14 = '';
    }
  }

  set fitopalogicoFp07(bool valor) {
    esFitopalogicoFp07.value = valor;
    if (valor) {
      _fitopalogicoFp07 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp07 = '';
    }
  }

  set fitopalogicoFp05(bool valor) {
    esFitopalogicoFp05.value = valor;
    if (valor) {
      _fitopalogicoFp05 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp05 = '';
    }
  }

  set fitopalogicoFp01(bool valor) {
    esFitopalogicoFp01.value = valor;
    if (valor) {
      _fitopalogicoFp01 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp01 = '';
    }
  }

  set fitopalogicoFp03(bool valor) {
    esFitopalogicoFp03.value = valor;
    if (valor) {
      _fitopalogicoFp03 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp03 = '';
    }
  }

  set fitopalogicoFp10(bool valor) {
    esFitopalogicoFp10.value = valor;
    if (valor) {
      _fitopalogicoFp10 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp10 = '';
    }
  }

  set fitopalogicoFp02(bool valor) {
    esFitopalogicoFp02.value = valor;
    if (valor) {
      _fitopalogicoFp02 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp02 = '';
    }
  }

  set fitopalogicoFp04(bool valor) {
    esFitopalogicoFp04.value = valor;
    if (valor) {
      _fitopalogicoFp04 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp04 = '';
    }
  }

  set fitopalogicoFp06(bool valor) {
    esFitopalogicoFp06.value = valor;
    if (valor) {
      _fitopalogicoFp06 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp06 = '';
    }
  }

  set fitopalogicoFp08(bool valor) {
    esFitopalogicoFp08.value = valor;
    if (valor) {
      _fitopalogicoFp08 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp08 = '';
    }
  }

  set fitopalogicoFp11(bool valor) {
    esFitopalogicoFp11.value = valor;
    if (valor) {
      _fitopalogicoFp11 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp11 = '';
    }
  }

  set fitopalogicoFp12(bool valor) {
    esFitopalogicoFp12.value = valor;
    if (valor) {
      _fitopalogicoFp12 =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _fitopalogicoFp12 = '';
    }
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? DEFECTO_A;
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  Future<void> generarCodigo() async {
    final provinciaContrato =
        await _seguimientoRepository.getProvinciaContrato();

    String fecha = '';

    if (_controlador.fechaOrdenLaboratorio != '') {
      fecha = _controlador.fechaOrdenLaboratorio;
    } else {
      fecha = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    }

    _controlador.fechaOrdenLaboratorio = fecha;

    String codigo = generarCodigoMuestra(
        provincia: provinciaContrato?.provincia ?? '',
        secuencia: _controlador.listaLaboratorio.length,
        fechaInicial: fecha.toString(),
        codigoFormulario: 'SCV');

    laboratorioModelo.codigoMuestra = codigo;
    codigoMuestra.value = codigo;
  }

  void _llenarAnalisis() {
    String? analisis;
    analisis = _identificacionInsectos +
        _extracion01 +
        _extracion02 +
        _extracion03 +
        _extracion06 +
        _extracion09 +
        _extracion12 +
        _extracion14 +
        _fitopalogicoFp07 +
        _fitopalogicoFp05 +
        _fitopalogicoFp01 +
        _fitopalogicoFp03 +
        _fitopalogicoFp10 +
        _fitopalogicoFp02 +
        _fitopalogicoFp04 +
        _fitopalogicoFp06 +
        _fitopalogicoFp08 +
        _fitopalogicoFp11 +
        _fitopalogicoFp12;
    analisis = removerNprimerosCaracteres(
        cadena: analisis, caracterSeparador: ',', cantidad: 2);

    laboratorioModelo.analisis = analisis;
  }

  bool validarFormulario() {
    bool esValido = true;
    _llenarAnalisis();

    if (laboratorioModelo.tipoMuestra == null) {
      errorTipoMuestra = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorTipoMuestra = null;
    }

    if (laboratorioModelo.aplicacionProductoQuimico == null) {
      errorProductoQuimico = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorProductoQuimico = null;
    }

    if (laboratorioModelo.prediagnostico == null ||
        laboratorioModelo.prediagnostico == '') {
      errorPrediagnostico = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorPrediagnostico = null;
    }

    if (laboratorioModelo.descripcionSintomas == null ||
        laboratorioModelo.descripcionSintomas == '') {
      errorDescripcionSintomas = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorDescripcionSintomas = null;
    }

    if (laboratorioModelo.analisis == null ||
        laboratorioModelo.analisis == '') {
      errorAnalisis.value = true;
      esValido = false;
    } else {
      errorAnalisis.value = false;
    }

    update(['idValidacion']);

    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarValidacion(mensaje: ALMACENANDO);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    _controlador.listaLaboratorio.add(laboratorioModelo);
    _controlador.cantidadOrdenes.value = _controlador.listaLaboratorio.length;

    finalizarValidacion(ALMACENADO_EXITO);

    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}
